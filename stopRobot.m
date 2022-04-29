function stopRobot(pub)
    stopMsg = rosmessage(pub);
    stopMsg.Data = [0 0];
    send(pub, stopMsg);
end

