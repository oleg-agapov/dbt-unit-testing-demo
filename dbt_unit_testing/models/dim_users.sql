with 

users as (
    select * from {{ ref('stg__users') }}
),

orders as (
    select * from {{ ref('stg__orders') }}
),

orders_per_user as (
    select
        user_id,
        count(*) as number_of_orders
    from orders
    group by user_id
)

select 
    users.user_id,
    users.email,
    users.city,
    coalesce(orders_per_user.number_of_orders, 0) as number_of_orders
from users
    left join orders_per_user
        on orders_per_user.user_id = users.user_id
