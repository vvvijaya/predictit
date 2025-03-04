with source as (
        select top 1 * from 
        --PREDICTIT.RAW."raw_market"
        PREDICTIT.RAW.raw_market
  ),
  renamed as (
      select
          * 
      from source
  )
  select * from renamed