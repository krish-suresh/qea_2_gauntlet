function weights = normalizeWeights(weights)
    weights = weights./sum(weights);
end

