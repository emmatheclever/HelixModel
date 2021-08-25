function animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, m_lengths_by_frame, show_Body, rest)
% Animates snake over changing c_coeffs configurations, stored as
% vectors in a cell array named "frames".

    % Initialize line
    fig = figure();
    ax = createAxes(fig);
    
    linkdata on
    grid on
    box(ax, 'on')
    hold on
    view(ax,3)
    
    theta_m = 2*pi/N_mcK;
    m_vecs = getMuscleVecs(N_mcK, a, theta_m);
  
    muscles = cell(1, N_mcK);

    [muscle_Data, separators, m_width, Z] = makeSnake(N_tot, N_seg, a, m_vecs, N_mcK, frames{1}, m_lengths_by_frame{1}, show_Body);
    max_Z = Z;
    min_Z = Z;
    
    if show_Body == 0
        body = cell(1, N_seg);
        for s = 1:N_seg
            body{s} = plot3(ax, separators{s,1}, separators{s,2}, separators{s,3}, "LineWidth", 3, 'Color', [17 17 17]/255);
        end
    else
        body = fmesh(ax, separators{1}, separators{2}, separators{3}, [0 2*pi 0 separators{4}]);
    end
    
    
    for m = 1:N_mcK
        muscles{m} = plot3(ax, muscle_Data{m,1}, muscle_Data{m,2}, muscle_Data{m,3}, 'Color', mcK_colors{m}, 'LineWidth', m_width);
    end
    
    
    syms p positive
    p_sol = solve(rest == N_tot*sqrt(p^2+(2*pi*a)^2), p);
    s_len = double(p_sol*N_tot)*1.1;
    
    xlim([-a*4 a*4])
    ylim([-a*4 a*4])
    zlim([-a*2 s_len])
    
    for i = 1 : length(frames)
        
        % Calculate updated data
        [new_ms, new_b, ~, Z] = makeSnake(N_tot, N_seg, a, m_vecs, N_mcK, frames{i}, m_lengths_by_frame{i}, show_Body);
        if Z > max_Z
            max_Z = Z;
        end
        if Z < min_Z
            min_Z = Z;
        end
        
        % Update figure muscle data
        for m = 1:N_mcK
            muscles{m}.XData = new_ms{m,1};
            muscles{m}.YData = new_ms{m,2};
            muscles{m}.ZData = new_ms{m,3};
        end
        
        % Update figure body data
        if show_Body == 0
            %body is an array of lines
            for s = 1:N_seg
                body{s}.XData = new_b{s,1};
                body{s}.YData = new_b{s,2};
                body{s}.ZData = new_b{s,3};
            end
            
        else
            % body is a surface object
            body.XFunction = new_b{1};
            body.YFunction = new_b{2};
            body.ZFunction = new_b{3};
            body.VRange = [0 new_b{4}];
        end

        % Extract current frame as an image
        frame = getframe(fig);
        if i == 1
            pos = get(fig, 'Position');
            width = pos(3);
            height = pos(4);

            % Preallocate data (for storing frame data)
            mov = zeros(height*2, width*2, 1, length(frames), 'uint8');
            % Store the frame and colormap
            [mov(:,:,1,i), map] = rgb2ind(frame.cdata, 256, 'nodither');
        else
            % Just store the frame using the calculated colormap
            mov(:,:,1,i) = rgb2ind(frame.cdata, map, 'nodither');
        end
    end
    imwrite(mov, map, 'animation.gif', 'DelayTime', 0, 'LoopCount', inf)
    
    disp(double(min_Z))
    disp(double(max_Z))
end