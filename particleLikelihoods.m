function weights = particleLikelihoods(particles,map,scan)
    angles = linspace(0,2*pi,360);
    weights = zeros(size(particles,1),1);
    boxsize = 0.3;
    for i=1:size(particles,1)
        scan_in_particle_frame = scanToGlobalFrame(scan,particles(i,:));
        for j=1:size(scan_in_particle_frame,1)
            if mod(j,5)==0
%                 plot(scan_in_particle_frame(j,1),scan_in_particle_frame(j,2),'r.');
                
                occ = checkOccupancy(map,scan_in_particle_frame(j,:)-[boxsize/2,boxsize/2],[boxsize,boxsize]);
                if sum(occ==1,"all") > 0
%                     plot(scan_in_particle_frame(j,1),scan_in_particle_frame(j,2),'g.');

                    weights(i) = weights(i) + 1;
                end
%                 intsectionPts = zeros(360,2);
%                 rayIntersection(map, particles(i,:),angles,3);
%                 dists = vecnorm((intsectionPts-particles(i,1:2))')';
%                 dists(isnan(dists)) = 0;
%                 weights(i) = sum(abs(scan-dists));
            end
        end
    end
%     weights = 1./weights;%.^3;
end

