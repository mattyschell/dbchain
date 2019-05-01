select sum(ST_NPoints(shape)) as
    "Number Of Points Before Simplification"
    from dbchaininput;
update dbchaininput
    set shape = ST_SimplifyVW(shape, :'vsimplifythreshhold')
where ST_NPoints(shape) > 2;
select sum(ST_NPoints(shape)) as
    "Number Of Points After Simplification"
    from dbchaininput;