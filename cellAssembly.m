classdef cellAssembly < analysisClass
    properties
        patient
        experiment
        timeBinWidth
        startStop
        centerOnRipples
        rippleTS = 'notComputed'
        channelsIncluded
        activityMatrix
        opts
        patterns
        

    end
    properties (Transient = true)
        timeBins
        lfpGroup
    end

    methods
        function obj = initializeCellAssembly(obj,lfpGroup,timeBinWidth,centerOnRipples,channelIndsToKeep,saveName)
            % define parameters from inputs
            obj.lfpGroup = lfpGroup;
            obj.saveName = saveName;
            obj.saveDir = lfpGroup.parentExperiment.saveDir;
            obj.patient = lfpGroup.parentExperiment.patient;
            obj.experiment = lfpGroup.parentExperiment.experiment;
            obj.timeBinWidth = timeBinWidth;
            obj.centerOnRipples = centerOnRipples;

            % convert the channelIndsToKeep input to a list of channelInds
            % if it's not already
            if isempty(channelIndsToKeep)
                channelIndsToKeep = 1:length(lfpGroup.lfpChannels);
            elseif isa(channelIndsToKeep, 'function_handle')
                channelIndsToKeep = find(arrayfun(@(x)channelIndsToKeep(x),lfpGroup.lfpChannels));
            elseif iscell(channelIndsToKeep) || ischar(channelIndsToKeep)
                if ischar(channelIndsToKeep)
                    channelIndsToKeep = {channelIndsToKeep};
                end
                regs = {lfpGroup.lfpChannels.reg};
                channelIndsToKeep = find(ismember(regs,channelIndsToKeep));
            elseif ~isnumeric(channelIndsToKeep)
                warning('Oh dear, I didn''t account for this possibility. Please deal with it here!')
                keyboard
            end
            obj.channelsIncluded = channelIndsToKeep;

            % set up the options for assembly detection (using the
            % defaults; these could subsequently be updated by hand)
            obj.opts.threshold.method = 'MarcenkoPastur';
            obj.opts.threshold.permutations_percentile = 95;
            obj.opts.threshold.number_of_permutations = 100;
            obj.opts.Patterns.method = 'ICA';
            obj.opts.Patterns.number_of_iterations = 100;

            if centerOnRipples
                obj.getRippleTS;
            end
            obj.generateTimeBins
            obj.generateActivityMatrix;
            obj.identifyCellAssemblies;
        end

        function obj = getRippleTS(obj)

        end

        function obj = generateTimeBins(obj)

        end

        function obj = generateActivityMatrix(obj)

        end

        function obj = identifyCellAssemblies(obj)

        end
    end

end