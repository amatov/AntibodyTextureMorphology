## Quick start

This repository contains an analysis of resistant and sensitive
gastric cancer cell immunofluorescence images before and after
docetaxel treatment, using the Murphy Lab's SLIC method (see LICENSE).

## Repository contents

- `createproc_GC_*.m`, `handseg_GC_*.m`, `handseg.m`,
  `feat_combine_auto.m`, `feat_lowcommon.m`, `feat_lowcommon_field.m`,
  `TTest_Features.m`, `TTest_FeaturesPAPER.m`, `Runner_0703_2013.m`,
  `SC_CellLevelFeatures_Wrapper.m` -- Murphy Lab template scripts,
  adapted only by substituting file paths to read my image dataset.
- `SLIC/`, `SC_CellLevelFeatures.m`, `sc_autofeatcalc.m`,
  `sc_feat_combine_auto.m`, `sc_fieldfeatcalc.m`,
  `SC_Retrieve_Features.m`, `sc_regionfeatmat.m`, `sc_handseg.m`,
  `sc_mkp_GC.m`, `tz_*.m` -- the bundled Murphy Lab SLIC toolbox.
- `ContrastStretchNorm.m` -- by Sergei Koptenko, Resonant Medical (see
  LICENSE).
- `results/` -- T-Test result files and a hand-segmentation mask.
- `reports/` -- analysis results.
- **License:** see [LICENSE](LICENSE) for the origin of all code in
  this repository.

## About

Analysis of immunofluorescence images of resistant and sensitive gastric cancer cells before and after docetaxel treatment; for detailed information, see: https://www.researchgate.net/publication/382853221_Quantitative_Microscopy_in_Medicine

Method from the lab of Bob Murphy, PhD at Carnegie Mellon - Mike Boland, Bob Murphy "A Neural Network Classifier Capable of Recognizing the Patterns of All Major Subcellular Structures in Fluorescence Microscope Images of HeLa Cells (2001)" 


