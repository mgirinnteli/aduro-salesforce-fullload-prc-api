%dw 2.0
output application/json
---
{
  transactionId: "string",
  datasync: [
    {
      datasyncId: "string",
      success: true,
      errors: [
        {
          statusCode: "string",
          message: "string",
          messageLocal: "string"
        }
      ]
    }
  ],
  status: "PARTIAL",
  action: "ADD",
  remarks: ""
}
