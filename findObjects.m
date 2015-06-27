function mine_regions = findObjects( img )

	% top-level function that finds mine and mine-like objects in a SONAR image.
	% takes `img` the image as an argument, cleans it (and possibly applies a gamma correction to it).
	
	% then follow this pipeline:
	% 	- find all level-1 contours in the image.
	% 	- threshold them on the basis of their shape [using PCA & length]
	% 	- obtain a region of interest around each contour.
	% 	- find SURF keypoint descriptors in each ROI.
	% 	- retain those ROIs which have some `N` matches.
	
	% `mine_regions` is a cell-array of final ROIs.
	
	img = medfilt2( rgb2gray(img), [3 3] );
	
	img = img.^1.1;
	
	C = contourc( img, [1 1] );
	
	retained_C = selectContours( C );
	retained_centres = getCentres( retained_C );
	boundingboxes = getBoundingBox( img, retained_centres, 1 );
	
	mine_regions = SURF_test( boundingboxes );
	
end	