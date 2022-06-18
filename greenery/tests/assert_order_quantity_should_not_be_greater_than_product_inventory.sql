select
    product_name,
    inventory,
    sum(quantity) as total_quantity
    
from {{ ref('int_product_orders__joined') }}
group by 1, 2
having 3 > inventory