using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Online_Pharmacy_BE.Models;

namespace Online_Pharmacy_BE.Controllers
{
    [Route("api/role")]
    [ApiController]
    public class RoleController : ControllerBase
    {
        private readonly OnlinePharmacyContext db;
        public RoleController(OnlinePharmacyContext context)
        {
            db = context;
        }

        [HttpGet("all")]
        public async Task<ActionResult<IEnumerable<Role>>> GetAllRole()
        {
            if (db.Roles == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }

            var _data = db.Roles.ToListAsync();
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data
            });
        }

        [HttpGet("get-by-id")]
        public async Task<ActionResult<IEnumerable<Role>>> GetRole(Guid id)
        {
            if (db.Roles == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _data = await db.Roles.Where(x => x.Id == id).ToListAsync();
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data
            });
        }

        [HttpPost("add")]
        public async Task<ActionResult> AddRole([FromBody] Role role)
        {
            if (role == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }

            db.Roles.Add(role);
            await db.SaveChangesAsync();
            return Ok(new
            {
                message = "Thêm dữ liệu thành công!",
                status = 200
            });
        }

        [HttpPut("edit")]
        public async Task<ActionResult> Edit([FromBody] Role role)
        {
            var _role = await db.Roles.FindAsync(role.Id);
            if (_role == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu không tồn tại!",
                    status = 400
                });
            }
            db.Entry(await db.Roles.FirstOrDefaultAsync(x => x.Id == role.Id)).CurrentValues.SetValues(role);
            await db.SaveChangesAsync();
            return Ok(new
            {
                message = "Sửa thành công!",
                status = 200
            });
        }

        [HttpDelete("delete")]
        public async Task<ActionResult> Delete([FromBody] Guid id)
        {
            if (db.Roles == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _role = await db.Roles.FindAsync(id);
            if (_role == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            try
            {
                db.Roles.Remove(_role);
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
                    message = "Lỗi rồi!",
                    status = 400,
                    data = e.Message
                });
            }
        }
    }
}