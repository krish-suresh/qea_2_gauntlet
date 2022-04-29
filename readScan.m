function scan = readScan(sub)
    scan_message = receive(sub);
    scan = scan_message.Ranges(1:end-1);
end

