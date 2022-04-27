function rosinitIfNotActive()
    if ~ros.internal.Global.isNodeActive
        rosinit
    end
end

