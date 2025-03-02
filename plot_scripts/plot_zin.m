function plot_zin(data_real, data_imag, title_, legend_, line_colors)
    figure('Renderer','painters');
    tiledlayout(2, 1,'TileSpacing','Compact','Padding','Compact');
    
    nexttile;
    p = plot(data_real(:,1), data_real(:,2:end),'LineWidth',1);
    if exist("line_colors", "var")
        for i = 1:size(line_colors, 2)
            set(p(i), 'Color', line_colors(i,:));
        end
    end
    title(title_);
    legend(legend_);
    grid on;
    grid minor;
    set(gca, 'YMinorGrid', 'off');
    ylim([0 65]);
    yticks(0:10:60);
    
    nexttile;
    p = plot(data_imag(:,1), data_imag(:,2:end),'LineWidth',1);
    if exist("line_colors", "var")
        for i = 1:size(line_colors, 1)
            set(p(i), 'Color', line_colors(i, :));
        end
    end
    grid on;
    grid minor;
    set(gca, 'YMinorGrid', 'off');
    ylim([-25 60]);
    yticks(-20:20:60);
    
    [file, path] = uiputfile('*.png', 'Save Image As'); % Open save dialog
    if file ~= 0  % Check if the user didn't cancel
        exportgraphics(gcf, fullfile(path, file), 'Resolution', 600);
    end
end