﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Online_Pharmacy_BE.Models;

namespace Online_Pharmacy_BE.Controllers
{
    [Route("api/product")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly OnlinePharmacyContext db;
        public ProductController(OnlinePharmacyContext context)
        {
            db = context;
        }

        [HttpGet("all")]
        public async Task<ActionResult<IEnumerable<Product>>> GetAllProduct()
        {
            if (db.Products == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _data = from product in db.Products
                        join category in db.Categories on product.IdCategory equals category.Id
                        orderby product.CreateAt descending
                        select new
                        {
                            product.Id,
                            product.Name,
                            product.Price,
                            product.Quantity,
                            product.CreateAt,
                            product.Detail,
                            product.IdUser,
                            product.PathImg,
                            category.Slug,
                            product.Type,
                            product.IdCategory,
                            categoryName = category.Name
                        };
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data
            }); ;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProduct(Guid id)
        {
            if (db.Products == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _data = await db.Products.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (_data == null)
            {
                return Ok(new
                {
                    message = "Lấy dữ liệu thất bại!",
                    status = 400
                });
            }
            var category = db.Categories.Find(_data.IdCategory);
            return Ok(new
            {
                message = "Lấy dữ liệu thành công!",
                status = 200,
                data = _data,
                category
            });
        }

        [HttpPost("add")]
        public async Task<ActionResult> AddProduct([FromBody] Product product)
        {
            await db.Products.AddAsync(product);
            await db.SaveChangesAsync();
            return Ok(new
            {
                message = "Tạo thành công!",
                status = 200,
                data = product
            });
        }

        [HttpPut("edit")]
        public async Task<ActionResult> Edit([FromBody] Product product)
        {
            var _product = await db.Products.FindAsync(product.Id);
            if (_product == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu không tồn tại!",
                    status = 400
                });
            }
            db.Entry(await db.Products.FirstOrDefaultAsync(x => x.Id == _product.Id)).CurrentValues.SetValues(product);
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
            if (db.Products == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            var _product = await db.Products.FindAsync(id);
            if (_product == null)
            {
                return Ok(new
                {
                    message = "Dữ liệu trống!",
                    status = 404
                });
            }
            try
            {
                db.Products.Remove(_product);
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
