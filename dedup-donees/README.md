Get some donees:

    mysql -e "use donations; select distinct(donee) from donations;" > temp
