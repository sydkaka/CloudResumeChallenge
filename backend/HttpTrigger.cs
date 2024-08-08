using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using Azure.Data.Tables;
using Backend.Model;
using System.Net;
using Newtonsoft.Json;
using System.Text;
using Azure;


namespace Backend.Function
{
    public class HttpTrigger
    {
        private readonly ILogger<HttpTrigger> _logger;

        public HttpTrigger(ILogger<HttpTrigger> logger)
        {
            _logger = logger;
        }

        [Function("HttpTrigger")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {   
            var response = req.CreateResponse();
            try{
            _logger.LogInformation("C# HTTP trigger function processed a request.");
            // New instance of the TableClient class
            TableServiceClient tableServiceClient = new TableServiceClient(Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING"));
            // New instance of TableClient class referencing the server-side table
            TableClient tableClient = tableServiceClient.GetTableClient(
                tableName: "ResumeTracker"
            );
            await tableClient.CreateIfNotExistsAsync();
            // Read a single item from container
            var record = await tableClient.GetEntityAsync<Counter>(
                rowKey: "index",
                partitionKey: "app"
            );
            Console.WriteLine("Counter Value was:");
            Console.WriteLine(record.Value.Count);

            // Update the record
            var updatedRecord =  new Counter()
            {
                RowKey = record.Value.RowKey,
                PartitionKey = record.Value.PartitionKey,
                Count = record.Value.Count + 1
            };
            await tableClient.UpdateEntityAsync<Counter>(updatedRecord, ETag.All);
            var result = new { Message = "Update Successful", Count = updatedRecord.Count};
            response.StatusCode = HttpStatusCode.OK;
            response.Headers.Add("Content-Type", "application/json; charset=utf-8");
            await response.WriteStringAsync(JsonConvert.SerializeObject(result));
            return response;
            }
            catch (Exception ex)
            {
                 _logger.LogError($"Exception occurred: {ex.Message}");
                var errorResult = new { Message = "An error occurred", Details = ex.Message };

                response.StatusCode = HttpStatusCode.InternalServerError;
                response.Headers.Add("Content-Type", "application/json; charset=utf-8");
                await response.WriteStringAsync(JsonConvert.SerializeObject(errorResult));

                return response;
            }
            
        }
    }
}
