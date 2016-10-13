/**
 * Need to style instead thanks to an overflow issue with ie10
 */
class FactWidget {
  constructor(options){
    this.container = options.element.append('div').attr('class', 'fact__inner').attr('style', 'width:100%;height:100%;');
    this.description = options.description || 'no fact available';
    this.init();
  }

  init(){
    this.container.append('p').attr('style', 'display:block;width:100%;height:100%;').text(this.description);
  }
}

module.exports = FactWidget;
