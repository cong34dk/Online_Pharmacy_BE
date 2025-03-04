using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Online_Pharmacy_BE.Models;

namespace Online_Pharmacy_BE.Controllers
{
    [Route("api/statistic")]
    [ApiController]
    public class StatisticController : ControllerBase
    {
        private readonly OnlinePharmacyContext db;
        public StatisticController(OnlinePharmacyContext context)
        {
            db = context;
        }

        [HttpGet("statistic")]
        public async Task<ActionResult> Statistic()
        {
            List<decimal> listTotal = new List<decimal>();
            DateTime day = DateTime.Now;
            int year = day.Year;
            for (int i = 1; i <= 12; i++)
            {
                decimal total = 0;
                total = Convert.ToDecimal((from order in db.Orders
                                           where order.CreateAt.Month == i
                                           where order.CreateAt.Year == year
                                           select order.Total).Sum());
                listTotal.Add(total);
            }
            decimal min = 0;
            decimal max = ((listTotal.Max()) * 120) / 100;
            return Ok(new
            {
                status = 200,
                message = "Thống kê doanh thu thành công!",
                data = listTotal
            });
        }
    }
}
