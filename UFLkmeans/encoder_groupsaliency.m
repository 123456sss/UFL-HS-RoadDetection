%% Group Saliency Coding
function code = encoder_groupsaliency(patch, centroids, knn)

z = CalDistMatL2(patch, centroids);
[zSort, idx] = sort(z, 2, 'ascend');

assign = zeros(size(patch,1), knn);
for k = 1:knn
    assign(:,k) = sum(zSort(:,k+1:knn+1), 2) - (knn+1-k)*zSort(:,k);
end
% for k = (knn-1):-1:1
%     assign(:,k) = max(assign(:,k:knn), [], 2);
% end

code = zeros(size(patch,1), size(centroids,1));
for i = 1:size(patch,1)
    for k = 1:knn
        code(i,idx(i,k)) = assign(i,k);
    end
end

