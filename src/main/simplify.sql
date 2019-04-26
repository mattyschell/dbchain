update dbchaininput
    set shape = ST_SimplifyVW(shape, :'vsimplifythreshhold')
where ST_NPoints(shape) > 2;