import addHasNegativeValueSpec from 'd3-charts-dto/spec/javascripts/Helpers/hasNegativeValueSpec.js';
import addCropDataSpec from './helpers/cropDataSpec.js';
import addNormalizeSpec from './helpers/normalizeSpec.js';
import addGetDateSpec from 'd3-charts-dto/spec/javascripts/Helpers/getDateSpec.js';
import addFormatSecondsSpec from 'd3-charts-dto/spec/javascripts/Helpers/formatSecondsSpec.js';

import addChartSpec from 'd3-charts-dto/spec/javascripts/Charts/ChartSpec.js';
import addLineChartSpec from 'd3-charts-dto/spec/javascripts/Charts/LineChartSpec.js';
import addBarChartSpec from 'd3-charts-dto/spec/javascripts/Charts/BarChartSpec.js';
import addStackBarChartSpec from 'd3-charts-dto/spec/javascripts/Charts/StackBarChartSpec.js';
import addStackBarChartNegativeSpec from 'd3-charts-dto/spec/javascripts/Charts/StackBarChartNegativeSpec.js';
import addPieChartSpec from 'd3-charts-dto/spec/javascripts/Charts/PieChartSpec.js';

// import addAxisSpec from 'd3-charts-dto/spec/javascripts/Charts/AxisSpec.js';
// // // import addXAxisSpec from 'd3-charts-dto/spec/javascripts/Charts/XAxisSpec.js';
// import addLayerSpec from 'd3-charts-dto/spec/javascripts/Charts/LayerSpec.js';
// import addOverlayLayerSpec from 'd3-charts-dto/spec/javascripts/Charts/OverlayLayerSpec.js';
//
// import addConvertDataForHeroSpec from './helpers/convertDataForHeroSpec.js';
// import addSparklineWidgetSpec from './Widgets/SparklineWidgetSpec.js';
// import addHeroWidgetSpec from './Widgets/HeroWidgetSpec.js';
// import addConvertDataSepc from './helpers/convertDataSpec';


describe('A suite', function() {
  it('contains spec with an expectation', function() {
    expect(true).toBe(true);
  });
});


window.testChartWidth = 200;


addHasNegativeValueSpec();
addCropDataSpec();
addNormalizeSpec();
addGetDateSpec();
addFormatSecondsSpec();

// addChartSpec();
// addLineChartSpec();
// addBarChartSpec();
// addStackBarChartSpec();
// addStackBarChartNegativeSpec();
// addAxisSpec();
// addLayerSpec();
// addOverlayLayerSpec();
// addPieChartSpec();
//
// addConvertDataForHeroSpec();
// addSparklineWidgetSpec();
// addHeroWidgetSpec();
// addConvertDataSepc();
