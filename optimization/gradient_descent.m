% Implements gradient descent with backtracking linesearch.

% f — function
% G — gradient
% x — multi-dimensional x value that we're initially at
% convergence_threshold
% N - max number of iterations, as safety net to prevent infinite looping


function [minimum_x, fx_at_minimum] = gradient_descent(f, G, x, convergence_threshold, N)

converged = false; % initialize as false
k = 1;
steps = zeros(1, N);

while ~converged % while not converged,
    % Make our search direction opposite of the gradient direction
    gradient = G(f, x);
    p = -gradient;

    % Find an optimal step size alpha
    alpha = backtracking(x, p, f, gradient);

    % Use this step size to move to a new location x in direction p
    new_x = x + alpha * p;

    % We check some convergence to see if the new x is good enough.
    % If it's not, we decide on a new direction, a step size, 
    % and take our move to a new point again
    distance_moved = abs(f(x) - f(new_x))
    if distance_moved >= convergence_threshold
        % Mark new x on plot
        subplot(1, 2, 1);
        plot(new_x(1,:), new_x(2,:), 'o', 'color', 'b'); % dot
        hold on; 
        plot([new_x(1,:) x(1,:)], [new_x(2,:), x(2,:)], 'b') % line
        hold on;
        
        % Move to new x
        x = new_x;
        steps(k) = distance_moved;
        k = k + 1
        
        % To prevent infinite loop, break after a maximum number of steps
        if k >= N
            break;
        end
    else
        converged = true; 
    end
end
    
minimum_x = new_x;
fx_at_minimum = f(new_x);

subplot(1, 2, 2);
steps = steps(1:k) % cut off steps we didn't use (we allowed N steps), this approach saves memory 
plot(1:k, steps, 'b');
xlabel('iteration');
ylabel('distance moved');

end

