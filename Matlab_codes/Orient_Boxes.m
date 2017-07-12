function or_box_mat = Orient_Boxes(phenotype, box_mat)

 n=length(box_mat);

or_box_mat = zeros(size(box_mat)); 

for i = 1:n
	switch phenotype(n+i)    
      case 1
         or_box_mat(phenotype(1,i),:) = box_mat(i,[1 2 3]);
      case 2
         or_box_mat(phenotype(1,i),:) = box_mat(i,[2 1 3]);
      case 3
         or_box_mat(phenotype(1,i),:) = box_mat(1,[1 3 2]);
      case 4
         or_box_mat(phenotype(1,i),:) = box_mat(i,[2 3 1]);
      case 5
         or_box_mat(phenotype(1,i),:) = box_mat(i,[3 1 2]);
      case 6
         or_box_mat(phenotype(1,i),:) = box_mat(i,[3 2 1]);
   end
end

