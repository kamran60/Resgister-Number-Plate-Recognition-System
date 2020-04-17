function container=guessing(Q,W,bsize)

for l=6:-1:2 
    val=find(Q==l); % Find the indices corresponding the value of frequency equals 'l'.
    var=length(val); % Check how many indices are found.
    if isempty(var) || var == 1 % If no index or one index is found.
        if val == 1
            index=val+1; % Since zero index is not allowed in MATLAB.
        else
            index=val; % Assign that value to 'index'.
        end
        if length(Q)==val % In case if the last index value is reached,
            index=[];     % then index+1 will be out of Q.
        end
        if Q(index)+Q(index+1) == 7 % If the sum of frequencies with the subsequent bin equals seven.
            container=[W(index)-(bsize/2) W(index+1)+(bsize/2)]; % Calculae container and break looping
            break;                                               % for more values.
        elseif Q(index)+Q(index-1) == 7 % If the sum of frequencies with the previous bin equals seven.
            container=[W(index-1)-(bsize/2) W(index)+(bsize/2)]; % Calculate container and break looping
            break;                                               % for more values.
        end
    else % If more than one index are found.
        for k=1:1:var % Repeat the analysis for every value of the bin and checks for the same condition
            if val(k)==1
                index=val(k)+1; % Since zero index is not allowed in MATLAB.
            else
                index=val(k); % that where the sum of frequencies equals seven.
            end
            if length(Q)==val(k) % In case if the last index value is reached,
                index=[];        % then index+1 will be out of Q.
            end
            if Q(index)+Q(index+1) == 7
                container=[W(index)-(bsize/2) W(index+1)+(bsize/2)]; % Calculate the value of container and break.
                break;
            elseif Q(index)+Q(index-1) == 7
                container=[W(index-1)-(bsize/2) W(index)+(bsize/2)];
                break;
            end
        end
        if k~=var % If for any value of index bins frequencies sum to seven then just break.
            break;
        end
    end
end
if l==2 % If looping is done and no frequencies sum to six then assign container the empty matrix.
    container=[];
end
end