function setWheelVel(pub, vL, vR)
    msg = rosmessage(pub);
    msg.Data = [vL, vR];
    send(pub, msg);
end

