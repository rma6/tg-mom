function plot_rad(gain_db, title_, legend_, angular_direction)

figure('Renderer','painters');
set(gcf, 'Position', get(0, 'Screensize'));
p = polarpattern(gain_db(:,1), gain_db(:,2:end), TitleTopTextInterpreter="tex", TitleTop = title_, MagnitudeLim=[-50,10], MagnitudeTick=[-40:10:10], LineWidth=1.2);
p.AngleTickLabel = string(p.AngleTickLabel) + char(176);
p.AngleTickLabel(1) = angular_direction + "=" + string(p.AngleTickLabel(1));
legend show
legendPos = get(legend, "Position");
legend('Position', [0.685, 0.79, legendPos(3), legendPos(4)], 'FontSize',14)
legend('String', legend_)

[file, path] = uiputfile('*.png', 'Save Image As'); % Open save dialog
if file ~= 0  % Check if the user didn't cancel
    exportgraphics(gcf, fullfile(path, file), 'Resolution', 600);
end