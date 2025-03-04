with source as (
        select top 1 * from         
        {{ source('PREDICTIT', 'markets') }}
  ),
  renamed as (
      select
          * 
      from source
  )
  select * from renamed
    