classdef PqPcaVladData < handle
    properties
        pqPcaEncodings
        encodings
        clusters
        adaptedCenters
        coeff
        pqClusters
        pqRotation
        pqDistances
        N_RESULTS
    end
    methods
        function obj = PqPcaVladData(pqPcaEncodings, encodings, clusters,...
                adaptedCenters, coeff, pqClusters, pqRotation, pqDistances, N_RESULTS)
            obj.pqPcaEncodings = pqPcaEncodings;
            obj.encodings = encodings;
            obj.clusters = clusters;
            obj.adaptedCenters = adaptedCenters;
            obj.coeff = coeff;
            obj.pqClusters = pqClusters;
            obj.pqRotation = pqRotation;
            obj.pqDistances = pqDistances;
            obj.N_RESULTS = N_RESULTS;
        end
    end
end