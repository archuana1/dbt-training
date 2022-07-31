select 
--raw_order
{{ dbt_utils.surrogate_key(['o.orderid', 'c.customerid','p.productid']) }} as sk_orders,
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice,
o.ordercostprice,
ordersellingprice - ordercostprice as orderprofit,
--raw_customer
c.customerid,
c.customername,
c.segment,
c.country,
--raw_products
p.productid,
p.category,
p.productname,
p.subcategory,
{{markup('ordersellingprice','ordercostprice')}} as markup,
d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p 
on o.productid = p.productid
left join {{ ref('delivery_team')}} as d 
on o.shipmode = d. shipmode

--{{ limit_data_in_dev('orderdate')}}
