function filtered_new_data = filterAroundPoint(room_data,point, radius)
    filtered_new_data = [];
    for i=1:size(room_data,1)
        if pdist([room_data(i,:); point]) > radius
            filtered_new_data = [filtered_new_data; room_data(i, :)];
        end
    end
end

