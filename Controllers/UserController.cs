using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Online_Pharmacy_BE.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace Online_Pharmacy_BE.Controllers
{
    [Route("api/user")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly OnlinePharmacyContext db;
        private readonly IConfiguration _config;

        public UserController(OnlinePharmacyContext context, IConfiguration config)
        {
            db = context;
            _config = config;
        }

        [HttpGet("all")]
        public async Task<ActionResult<IEnumerable<User>>> GetAllUser()
        {
            if (db.Users == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _data = from x in db.Users
                        join role in db.Roles on x.IdRole equals role.Id
                        select new
                        {
                            x.Id,
                            x.Name,
                            x.Email,
                            x.Password,
                            x.Phone,
                            x.Address,
                            x.CreateAt,
                            x.IdRole,
                            x.PathImg,
                            nameRole = role.Name,
                        };

            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data
            });
        }

        [HttpGet("get-by-id")]
        public async Task<ActionResult<IEnumerable<User>>> GetUser(Guid id)
        {
            if (db.Users == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _data = await db.Users.Where(x => x.Id == id).ToListAsync();
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data
            }); ;
        }

        [HttpPost("register")]
        public async Task<ActionResult> AddUser([FromBody] User user)
        {
            var _user = await db.Users.FirstOrDefaultAsync(x => x.Email == user.Email);
            if (_user != null)
            {
                return Ok(new
                {
                    message = "Email đã tồn tại!",
                    status = 400
                });
            }
            var role = await db.Roles.Where(x => x.Name.Equals("Guest")).FirstOrDefaultAsync();
            if (user.IdRole == null)
            {
                user.IdRole = role.Id;
            }
            await db.Users.AddAsync(user);
            await db.SaveChangesAsync();
            return Ok(new
            {
                message = "Tạo thành công!",
                status = 200,
                data = user
            });
        }

        [HttpPut("edit")]
        public async Task<ActionResult> Edit([FromBody] User user)
        {
            var _user = await db.Users.FindAsync(user.Id);
            if (_user == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu không tồn tại!",
                    status = 400
                });
            }
            db.Entry(await db.Users.FirstOrDefaultAsync(x => x.Id == _user.Id)).CurrentValues.SetValues(user);
            var __user = (from nv in db.Users
                          where nv.Id == user.Id
                          select new
                          {
                              nv.Id,
                              nv.Password,
                              nv.Email,
                              nv.IdRole,
                              nv.PathImg,
                              nv.Address,
                              nv.Name,
                              nv.CreateAt,
                              nv.Phone,
                              role = db.Roles.Where(x => x.Id == nv.IdRole).FirstOrDefault().Name
                          }).ToList();
            await db.SaveChangesAsync();
            return Ok(new
            {
                message = "Sửa thành công!",
                status = 200,
                data = __user
            });
        }

        [HttpDelete("delete")]
        public async Task<ActionResult> Delete([FromBody] Guid id)
        {
            if (db.Users == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _user = await db.Users.FindAsync(id);
            if (_user == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            try
            {
                db.Users.Remove(_user);
                await db.SaveChangesAsync();
                return Ok(new
                {
                    message = "Xóa thành công!",
                    status = 200
                });
            }
            catch (Exception e)
            {
                return Ok(new
                {
                    message = "Có lỗi xảy ra!",
                    status = 400,
                    data = e.Message
                });
            }
        }

        [HttpPost("login")]
        public async Task<ActionResult> Login([FromBody] Login user)
        {
            var _user = (from nv in db.Users
                         where nv.Email == user.email
                         select new
                         {
                             nv.Id,
                             nv.Password,
                             nv.Email,
                             nv.PathImg,
                             nv.IdRole,
                             nv.Address,
                             nv.Name,
                             nv.CreateAt,
                             nv.Phone,
                             role = db.Roles.Where(x => x.Id == nv.IdRole).FirstOrDefault().Name
                         }).ToList();
            if (_user.Count == 0)
            {
                return Ok(new
                {
                    message = "Tài khoản không tồn tại",
                    status = 404
                });
            }
            if (user.password != _user[0].Password)
            {
                return Ok(new
                {
                    message = "Sai mật khẩu",
                    status = 400
                });
            }
            return Ok(new
            {
                message = "Thành công",
                status = 200,
                data = _user,
            });
        }

        [HttpGet("info")]
        public ActionResult GetDataFromToken(string token)
        {
            if (token == "undefined")
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 400
                });
            }
            string _token = token.Split(' ')[1];
            if (_token == null)
            {
                return Ok(new
                {
                    message = "Token không đúng!",
                    status = 400
                });
            }
            var handle = new JwtSecurityTokenHandler();
            string email = Regex.Match(JsonSerializer.Serialize(handle.ReadJwtToken(_token)), "emailaddress\",\"Value\":\"(.*?)\",").Groups[1].Value;
            var _user = db.Users.Where(x => x.Email == email).FirstOrDefault();
            if (_user == null)
            {
                return Ok(new
                {
                    message = "Người dùng không tồn tại!",
                    status = 404
                });
            }
            var role = db.Roles.Find(_user.IdRole);
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _user,
                role = role.Name
            });
        }

        [HttpPost("change-password")]
        public ActionResult ChangePassword([FromBody] ChangePassword changePassword)
        {
            var user = db.Users.Find(changePassword.idUser);
            if (user == null)
            {
                return Ok(new
                {
                    message = "Người dùng không tồn tại!",
                    status = 200
                });
            }
            if (changePassword.oldPassword != user.Password)
            {
                return Ok(new
                {
                    message = "Mật khẩu cũ không đúng!",
                    status = 400
                });
            }
            db.Entry(db.Users.FirstOrDefault(x => x.Id == user.Id)).CurrentValues.SetValues(user);
            db.SaveChanges();
            return Ok(new
            {
                message = "Thay đổi mật khẩu thành công!",
                status = 200
            });
        }

    }

    public class Login
    {
        public string email { get; set; }
        public string password { get; set; }
    }
    public class ChangePassword
    {
        public Guid idUser { get; set; }
        public string oldPassword { get; set; }
        public string newPassword { get; set; }
    }
}

