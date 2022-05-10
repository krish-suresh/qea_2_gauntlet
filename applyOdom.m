function [particles,weights] = applyOdom(particles, odom, map, weights)
    removeIdx = [];
    for i = 1:size(particles,1)
        theta = angleWrap(particles(i,3)-pi/2);
        particles(i,1:2) = (particles(i,1:2)' + [cos(theta) -sin(theta);sin(theta) cos(theta)]*odom(1:2)')';
        particles(i,3) = angleWrap(particles(i,3) + odom(3));
        if checkOccupancy(map,particles(i,1:2))
            removeIdx = [removeIdx;i];
        end
    end
    avg_weight = 1/size(particles,1);
    for i=1:length(removeIdx)
        while true
            new_particle = [randWithinRange(map.XWorldLimits), randWithinRange(map.YWorldLimits),randWithinRange([-pi,pi])];
            if ~checkOccupancy(map,new_particle(1:2))
                particles(removeIdx(i),:) = new_particle;
                break;
            end
        end
        weights(removeIdx) = avg_weight;
    end
end

