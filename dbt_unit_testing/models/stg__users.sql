select * 
from {{ source('postgres', 'users') }}
