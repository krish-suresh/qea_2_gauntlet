function a = angleWrap(ang)
    while (ang <-pi)
        ang = ang + pi*2;
    end
    while (ang >pi)
        ang = ang - pi*2;
    end
    a = ang;
end