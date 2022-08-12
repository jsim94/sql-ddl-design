SELECT tickets.id,
  first_name,
  last_name,
  seat,
  flightid,
  departure,
  arrival,
  airline,
  oCity.city AS origin_city,
  oCont.country AS origin_country,
  dCity.city AS destination_city,
  dCont.country AS destination_country
FROM tickets
  JOIN customers ON customerid = customers.id
  JOIN flights ON flightid = flights.id
  JOIN airlines ON airlineid = airlines.id
  JOIN cities oCity ON flights.originid = oCity.id
  JOIN cities dCity ON flights.destinationid = dCity.id
  JOIN countries oCont ON oCity.country = oCont.id
  JOIN countries dCont ON dCity.country = dCont.id
WHERE EXTRACT(
    YEAR
    FROM departure
  ) = 2019
ORDER BY tickets.id;