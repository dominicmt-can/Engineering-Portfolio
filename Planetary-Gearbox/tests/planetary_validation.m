%% Epicyclic Gear Train Geometric & Mesh Validation
% Description: Sizing verification, kinematic constraint validation, and 
% multi-tooth profile plotting with DFAM backlash offsets.

clear; clc; close all;

%% 1. Input Design Parameters
m = 2.5;                % Module (mm)
alpha_deg = 20;         % Pressure angle (degrees)
Ns = 24;                % Sun gear teeth
Np = 12;                % Planet gear teeth
Nr = 48;                % Ring gear teeth
P = 3;                  % Number of planets
backlash_offset = 0.20; % Radial clearance offset (mm)

%% 2. Kinematic & Geometric Assembly Checks
alpha = deg2rad(alpha_deg);

concentric_check = (Nr == Ns + 2*Np);
spacing_val = (Ns + Nr) / P;
spacing_check = (mod(Ns + Nr, P) == 0);
a = (m * (Ns + Np)) / 2;
gear_ratio = 1 + (Nr / Ns);

%% 3. Direct Contact Ratio & Length Validation
term_sun    = sqrt((Ns + 2)^2 - (Ns * cos(alpha))^2);
term_planet = sqrt((Np + 2)^2 - (Np * cos(alpha))^2);
term_span   = (Ns + Np) * sin(alpha);

contact_length = (m / 2) * (term_sun + term_planet - term_span);
contact_ratio  = (term_sun + term_planet - term_span) / (2 * pi * cos(alpha));

%% 4. Command Window Metrics Display
fprintf('================ EXACT PLANETARY METRICS ================\n');
fprintf('Module (m):            %.1f mm\n', m);
fprintf('Pressure Angle:        %d deg\n', alpha_deg);
fprintf('Tooth Counts:          Sun: %d | Planet: %d | Ring: %d\n', Ns, Np, Nr);
fprintf('Center Distance (a):   %.2f mm\n', a);
fprintf('Reduction Ratio:       %.2f : 1\n', gear_ratio);
fprintf('Concentricity Check:   %s (Nr = Ns + 2*Np)\n', mat2str(concentric_check));
fprintf('Equispaced Spacing:    %s ((%d + %d)/%d = %.1f)\n', ...
    mat2str(spacing_check), Ns, Nr, P, spacing_val);
fprintf('--------------------------------------------------------\n');
fprintf('Active Contact Length: %.3f mm\n', contact_length);
fprintf('Contact Ratio (eps):   %.3f\n', contact_ratio);
if contact_ratio >= 1.2
    fprintf('Mesh Status:           PASS (Continuous load sharing >= 1.2)\n');
else
    fprintf('Mesh Status:           FAIL (Risk of tooth clash / discontinuity)\n');
end
fprintf('========================================================\n');

%% 5. Multi-Tooth Involute Plotting
rs   = (m * Ns) / 2;               % 30.0 mm
rb_s = rs * cos(alpha);            % 28.19 mm
ra_s = rs + m;                     % 32.5 mm

% Parametric involute base curve
t_max = sqrt((ra_s / rb_s)^2 - 1);
t = linspace(0, t_max, 40);

x_inv = rb_s * (cos(t) + t .* sin(t));
y_inv = rb_s * (sin(t) - t .* cos(t));

inv_alpha = tan(alpha) - alpha;
th_half = (pi / (2 * Ns)) + inv_alpha;
d_th = backlash_offset / rs;

num_teeth = 3;
pitch_angle = 2 * pi / Ns;

figure;
hold on; 
grid on;

% 1. Plot Reference Arcs
th_arc = linspace(-0.5 * pitch_angle, (num_teeth - 0.5) * pitch_angle, 100);
plot(ra_s * cos(th_arc), ra_s * sin(th_arc), 'r--', 'LineWidth', 1.2);
plot(rs   * cos(th_arc), rs   * sin(th_arc), 'b-.', 'LineWidth', 1.2);
plot(rb_s * cos(th_arc), rb_s * sin(th_arc), 'k--', 'LineWidth', 1.2);

% 2. Plot Teeth
for k = 0:(num_teeth - 1)
    center_ang = k * pitch_angle;
    
    % FDM Profile (Thinner inner geometry) -> Plotted in Black
    ar = center_ang + th_half;
    xr = x_inv * cos(ar) - y_inv * sin(ar);
    yr = x_inv * sin(ar) + y_inv * cos(ar);
    
    al = center_ang - th_half;
    xl = x_inv * cos(al) + y_inv * sin(al);
    yl = x_inv * sin(al) - y_inv * cos(al);
    
    plot([xr, fliplr(xl)], [yr, fliplr(yl)], 'k-', 'LineWidth', 1.8);
    
    % Nominal Profile (Wider outer geometry) -> Plotted in Magenta
    ar_f = center_ang + th_half - d_th;
    xr_f = x_inv * cos(ar_f) - y_inv * sin(ar_f);
    yr_f = x_inv * sin(ar_f) + y_inv * cos(ar_f);
    
    al_f = center_ang - th_half + d_th;
    xl_f = x_inv * cos(al_f) + y_inv * sin(al_f);
    yl_f = x_inv * sin(al_f) - y_inv * cos(al_f);
    
    plot([xr_f, fliplr(xl_f)], [yr_f, fliplr(yl_f)], 'm-', 'LineWidth', 1.4);
end

title(sprintf('Sun Gear Involute Profile (m = %.1f, N = %d)', m, Ns));
xlabel('X (mm)'); 
ylabel('Y (mm)');
legend({'Addendum Circle', 'Pitch Circle', 'Base Circle', 'FDM Profile (-0.20 mm)', 'Nominal Profile'}, ...
       'Location', 'northwest');

axis equal;