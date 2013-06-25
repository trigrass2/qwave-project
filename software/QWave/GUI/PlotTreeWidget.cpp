//
//   PlotTreeWidget.cpp
//   QWave
//   Copyright (c) 2012-2013, Bruno Kremel
//   All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//    1. Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//    2. Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//    3. All advertising materials mentioning features or use of this software
//       must display the following acknowledgement:
//       This product includes software developed by Bruno Kremel.
//    4. Neither the name of Bruno Kremel nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY Bruno Kremel ''AS IS'' AND ANY
//    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//    DISCLAIMED. IN NO EVENT SHALL Bruno Kremel BE LIABLE FOR ANY
//    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include "PlotTreeWidget.h"
#include "../Exceptions/IOException.h"
#include <QTreeWidgetItem>
#include <QAbstractItemView>


PlotTreeWidget::PlotTreeWidget(QWidget * parent) : QWidget(parent)
{
   ui.setupUi(this);
}

void PlotTreeWidget::setModel(PlotTreeModel * model)
{
    treeModel = model;
    ui.treeView->setModel(treeModel);
    ui.treeView->setSelectionModel(new QItemSelectionModel(treeModel));
    connect(ui.treeView->selectionModel(), SIGNAL(currentChanged(const QModelIndex&,const QModelIndex&)), this, SLOT(signalizeChangedItem()));
}

/**
 * Returns selected item in tree.
 */
PlotTreeItem * PlotTreeWidget::selectedItem()
{
    QModelIndex index = ui.treeView->selectionModel()->currentIndex();
    return static_cast<PlotTreeItem*>(treeModel->itemFromIndex(index));
}

/**
 * @brief PlotTreeWidget::signalizeChangedItem emits signal that item was selected
 */
void PlotTreeWidget::signalizeChangedItem()
{
    emit itemSelected();
}

