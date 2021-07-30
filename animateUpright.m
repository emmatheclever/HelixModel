function animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, m_lengths_by_frame, show_Body)
% Animates snake upright over changing c_coeffs configurations, stored as
% vectors in a cell array named "frames"

    % Initialize line
    fig = figure();
    ax = createAxes(fig);
    
    theta_m = 2*pi/N_mcK;
    m_vecs = getMuscleVecs(N_mcK, a, theta_m);
    
    muscles = cell(1, N_mcK);

    [muscle_Data, body, m_width] = makeSnake(ax, N_tot, N_seg, a, m_vecs, N_mcK, frames{1}, m_lengths_by_frame{1}, show_Body);
    
    for m = 1:N_mcK
        muscles{m} = plot3(ax, muscle_Data{m,1}, muscle_Data{m,2}, muscle_Data{m,3}, 'Color', mcK_colors{m}, 'LineWidth', m_width);
    end
    
    linkdata on
    
    xlim([-8 8])
    ylim([-8 8])
    zlim([-5 35])
    
    for i = 1 : length(frames)
        
        % Calculate updated data
        [new_ms, new_b] = makeSnake(ax, N_tot, N_seg, a, m_vecs, N_mcK, frames{i}, m_lengths_by_frame{i}, show_Body);

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
                body{s}.XData = new_b{s}.XData;
                body{s}.YData = new_b{s}.YData;
                body{s}.ZData = new_b{s}.ZData;
                body{s}.Color = new_b{s}.Color;
                body{s}.Visible = 'on';
            end
            
        else
            % body is a surface object
            body.XData = new_b.XData;
            body.YData = new_b.YData;
            body.ZData = new_b.ZData;
            body.CData = new_b.CData;
            body.Visible = 'on';
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
    
end