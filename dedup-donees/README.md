Get some donees:

    mysql -e "use donations; select distinct(donee) from donations;" | sort > temp

Get biggest donees:

     mysql -e "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" > temp3
