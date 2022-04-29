function enc_data = readEncoders(sub)
    [msg2,~,~] = receive(sub,10);
    enc_data = msg2.Data;
end

