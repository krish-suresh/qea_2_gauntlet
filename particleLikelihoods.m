function weights = particleLikelihoods(particles,map,scan)
    angles = linspace(0,2*pi,360);
    weights = zeros(size(particles,1),1);
    for i=1:size(particles,1)
        scan_in_particle_frame = scanToGlobalFrame(scan,particles(i,:));
        for j=1:size(scan_in_particle_frame,1)
            if mod(j,10)==0
                occ = checkOccupancy(map,scan_in_particle_frame(j,:),[0.2,0.2]);
                if sum(occ==1) > 0
                    weights(i) = weights(i) + 1;
                end
%                 intsectionPts = zeros(360,2);
                %rayIntersection(map, particles(i,:),angles,3);
%                 dists = vecnorm((intsectionPts-particles(i,1:2))')';
%                 dists(isnan(dists)) = 0;
%                 weights(i) = sum(abs(scan-dists));
            end
        end
    end
    weights = weights.^3;
end

