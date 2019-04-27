function environment = getEnvironment(varargin)
    % GETENVIRONMENT takes variable input arguments and creates an
    % environment struct with its properties. If an error is detected, the
    % default environment is returned.
    
    % Initialize environment as struct
    environment = struct;
    
    % Set default environment
    environment.g = 9.81; % [m/s]
    environment.dt = 0.01; % [s]
    
    if nargin == 0
        return
    elseif nargin == 1 % If only one argument is provided, overwrite dt
        environment.dt = varargin{1};
    elseif mod(nargin,2) == 0 % Loop through settings
        argnum = 1;
        while argmun + 1 <= nargin
            if ischar(varargin{argnum})
                switch varargin{argnum}
                    case 'g'
                        environment.g = varargin{argnum + 1};
                    case 'dt'
                        environment.dt = varargin{argnum + 1};
                    otherwise
                        warning('Unidentified argument, setting environment as default.')
                        environment = getEnvironment();
                        return
                end
            else % Non char setting
                warning('Non-char setting detected, setting environment as default.')
                environment = getEnvironment();
                return
            end
            
            argnum = argnum + 2;
        end
    else
        warning('Uneven number of input variables, setting environment as default.')
        environment = getEnvironment();
    end
end

