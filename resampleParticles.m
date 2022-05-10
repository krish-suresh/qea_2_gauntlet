function new_particles = resampleParticles(particles,weights)
    bins = cumsum(weights);
%     [~,~,indicies] = histcounts(rand(length(weights), 1),bins);
    indicies = resampleMultinomial(weights);
    new_particles = [];
    sig_lat = 100;
    for i=1:length(indicies)
        noise = [randn(1)./sig_lat, randn(1)./sig_lat, randn(1)./10];
        new_particles = [new_particles; particles(indicies(i),:)+noise];
    end
end

