function animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, mcK_rest, mcK_act, show_Body)
% Animates snake upright over changing c_coeffs configurations, stored as
% vectors in a cell array named "frames"

    % Initialize line
    fig = figure();
    ax = createAxes(fig);
    
    m_lengths = calculateLengths(N_mcK, frames{1}, mcK_rest, mcK_act);
    theta_m = 2*pi/N_mcK;
    m_vecs = getMuscleVecs(N_mcK, a, theta_m);

    [muscles, body] = makeSnake(ax, N_tot, N_seg, a, m_vecs, N_mcK, mcK_colors, frames{1}, m_lengths, show_Body)
    linkdata on
    xlim([-10 10])
    ylim([-10 10])
    zlim([0 35])
    
    for i = 1 : length(frames)
        % Calculate updated data
        m_lengths = calculateLengths(N_mcK, frames{i}, mcK_rest, mcK_act);
        [new_ms, new_b] = makeSnake(ax, N_tot, N_seg, a,m_vecs, N_mcK, mcK_colors, frames{i}, m_lengths, show_Body);

        % Update figure muscle data
        for m = 1:N_mcK
            muscles{m}.XData = new_ms{m}.XData;
            muscles{m}.YData = new_ms{m}.YData;
            muscles{m}.ZData = new_ms{m}.ZData;
            muscles{m}.Color = new_ms{m}.Color;
            muscles{m}.Visible = 'on';
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