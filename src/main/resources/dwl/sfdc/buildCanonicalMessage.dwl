%dw 2.0
import * from dw::core::Strings
output application/json
fun replaceAduro(field) = (field replace('aduro__') with ('')) replace('aduro') with ('')
fun formatField(field) = substring(if(field contains('__c')) camelize(replaceAduro(substringBefore(field, '__c'))) else camelize(replaceAduro(field)),0,39)
fun checkArray(field) = if(typeOf(field) contains 'Array') ((field default []) map (item, index) -> {(item mapObject (value,key,index) ->  { (formatField(key)): value })}) else field
fun checkObject(field) = if(typeOf(field) contains 'Object') ((([field] default []) map (item, index) -> {(item mapObject (value,key,index) ->  { (formatField(key)): value })}))[0] else field
---
{
	meta: {
		source: 'SALESFORCE',
		target: 'DATACLOUD',
		entity: vars.entityName,
		sfEntity: vars.sfEntityName,
		sdcEntity: vars.sdEntityName,
		orgId: vars.orgId,
    	timestamp: now(),
    	operation: 'AD_HOC_FULL_LOAD'
	},
	data: (vars.sfResults default []) map (item, index) -> {(item mapObject (value,key,index) ->  { (formatField(key)): checkArray(checkObject(value)) })}
}