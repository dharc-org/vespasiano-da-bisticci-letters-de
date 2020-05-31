
Vespasiano da Bisticci's Letters
================================

.. toctree::
   :maxdepth: 2
   :hidden:

   methodology
   structure-and-components
   visualization

Overview
--------
Vespasiano da Bisticci’s *Letters* are a series of manuscript letters sent to and received by Vespasiano da Bisticci (1421–1498), an Italian humanist and librarian, over a time period spanning from 1444 to 1497. Their content focuses mostly on manuscripts and codex trade with other notable people of that time. From the letters it is possible to learn many relevant features of these manuscripts: materials, copyists, costs, but also names of latin, greek and humanistic authors and texts. Their physical copies are currently held in different repositories (archives and libraries). They arrived under different physical supports, and were not gathered in an existing collection. 

A **semantic digital edition** of the Letters has been produced in order to facilitate the navigation, study and conservation of such documents, as well as to contextualize them in a semantically-rich and metatextual framework. Overall, many data elements have been used to formulate descriptive paratextual statements about the letters in the annotation process that brought the semantic digital edition to life.

The **HTML version** of the digital edition of the Letters can be found here: http://vespasianodabisticciletters.unibo.it/.

The **RDF-based, semantic digital edition** of the Letters can be found here: http://projects.dharc.unibo.it/vespasiano/. It can be set up locally by following the instructions that can be found in the rest of this page.

The rest of the documentation is organized as follows:

* **Methodology**: this section explains in detail the methodology used to develop the digital edition, which comprises the **development workflow** and the list of **reused models**;
* **Structure and components**: this section explains in detail the structure of the RDF graph by dividing it into **a series of smaller models**;
* **Visualization**: this section illustrates some examples of SPARQL queries on the graph, rendered as **visualization charts**.

How to set up the semantic digital edition
-------------------------------------------
As it is, the data can be processed through **node.js** (https://nodejs.org/en/), an open source server environment that allows to generate dynamic page content and manipulate data in the graph through an event-driven, asyncronous management of operations.

The data can be queried via **rdflib**, a library for working with RDF that allows one to read and write code in RDF/XML and other serializations (such as Turtle and N3).
This library also allows one to make SPARQL queries.

In order to launch the application locally, you will need a web server (e.g. XAMPP, https://www.apachefriends.org/it/index.html), ``node.js`` and the directory ``node_modules`` downloaded on your machine.

**XAMPP**, which includes the Apache web server, can be used to set up a server on a computer.
You can download XAMPP here: https://www.apachefriends.org/download.html.
Run ``xampp-control.exe`` as administrator.
Click on the *Start* button next to the *Apache* module.

.. note:: 
    Do *not* install XAMPP under ``C:\Program files`` on Windows 10, because it may cause problems with permissions later. Put it in root (``C:\``) instead.

Now you may open a web browser and go to ``http://localhost:80``, or alternatively just ``http://localhost``. You are now in contact with the web server you just installed and started.
Locate the ``htdocs`` folder of the directory in which XAMPP was installed.

Run the command prompt and move to the folder containing the ``vespasiano``. Then, launch ``app.js``:

::

>> node app.js

You will be able to visualize the digital edition on any browser at ``localhost:80``.

.. note::
    On some computers, another server may already be listening to ``port 80``. If so, you may need to terminate that server or move the XAMPP server to another port.
