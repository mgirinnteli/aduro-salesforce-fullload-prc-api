%dw 2.0
output application/java
fun formatDate(dateString)= dateString as String  {format: "yyyy-MM-dd"} as Date default " "
fun formatDateTime(dateString)= dateString as String  {format: "yyyy-MM-dd'T'HH:mm:ss:SSSZ"} as DateTime default " "
---
vars.requestBody map {
    ($  update {
        case .aduro_ModifiedDate__c -> ($ as String  {format: "yyyy-MM-dd'T'HH:mm:ss:SSSZ"} as DateTime) default " "
        case .aduro_StartDate__c -> ($ as String {format: "yyyy-MM-dd"} as Date) default " "
	})
}
