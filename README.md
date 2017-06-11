# Leaf-Classification

**Problem Statement**: Comparing leaves to find out the type of plant is challenging for botanists and consumers. 
Often it takes a knowledgeable botanist to extract meaningful information from  a leaf, and a patient, 
motivated consumer with the right resources  to verify the identity of a plant.

## Approach 
1. Histogram Based Segmentation using OTSU gray level thresholding
2. Morphological processes (erosion + dilation) to get rid of noise and extract the image
3. Feature Extraction by finding the Major X-Axis and Y-Axis for comparison
