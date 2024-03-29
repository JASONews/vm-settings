'use babel';

import ExpandCharView from './expand-char-view';
import { CompositeDisposable } from 'atom';

export default {

  expandCharView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.expandCharView = new ExpandCharView(state.expandCharViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.expandCharView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'expand-char:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.expandCharView.destroy();
  },

  serialize() {
    return {
      expandCharViewState: this.expandCharView.serialize()
    };
  },

  toggle() {
    console.log('ExpandChar was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
