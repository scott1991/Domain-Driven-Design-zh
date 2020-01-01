# 第二部分 模型驱动设计的构造块

> II: The Building Blocks of a Model-Driven Design

To keep a software implementation crisp and in lockstep with a model, in spite of messy realities, you must apply the best practices of modeling and design. This book is not an introduction to object-oriented design, nor does it propose radical design fundamentals. Domain-driven design shifts the emphasis of certain conventional ideas.

> 为了保证软件实现得简洁并且与模型保持一致，不管实际情况如何复杂，必须运用建模和设计的最佳实践。本书既不是一本介绍面向对象设计的书，也不是为了提出一些基本的设计原理。领域驱动设计改变了某些传统观念的侧重点。

Certain kinds of decisions keep the model and implementation aligned with each other, each reinforcing the other’s effectiveness. This alignment requires attention to the details of individual elements. Careful crafting at this small scale gives developers a steady platform from which to apply the modeling approaches of Parts III and IV.

> 某些设计决策能够使模型和程序紧密结合在一起，互相促进对方的效用。这种结合要求我们注意每个元素的细节。对细节问题的精雕细琢能够打造出一个稳定的平台，开发人员可以在这个平台上运用第三部分和第四部分中要讲到的建模方法。

The design style in this book largely follows the principle of “responsibility-driven design,” put forward in Wirfs-Brock et al. 1990 and updated in Wirfs-Brock 2003. It also draws heavily (especially in Part III) on the ideas of “design by contract” described in Meyer 1988. It is consistent with the general background of other widely held best practices of object-oriented design, which are described in such books as Larman 1998.

> 本书中的软件设计风格主要遵循“职责驱动设计”的原则，这个原则是在[Wirfs-Brock et al.1990]中提出的，并在[Wirfs-Brock 2003]中进行了更新。同时本书也大量利用了[Meyer 1988]中所提出的“契约式设计”思想。它与其他被广泛采用的面向对象设计最佳实践有着基本相同的背景，这些最佳实践在[Larman 1998]等书中给出了描述。

As a project hits bumps, large or small, developers may find themselves in situations that make those principles seem inapplicable. To make the domain-driven design process resilient, developers need to understand how the well-known fundamentals support MODEL-DRIVEN DESIGN, so they can compromise without derailing.

> 当项目遇到或大或小的困难时，开发人员可能会发现这些原则都无法适用于项目当前的状况。为了使领域驱动设计过程更灵活，开发人员需要理解上面这些众所周知的基本原理是如何支持MODEL-DRIVEN DESIGN的，这样才能在设计过程中做出一些折中选择，而又不脱离正确的轨道。

The material in the following three chapters is organized as a “pattern language” (see Appendix A), which will show how subtle model distinctions and design decisions affect the domain-driven design process.

> 下面3章的内容是按照“模式语言”（参见附录A）组织的，主要说明了细微的模型差别和设计决策是如何影响领域驱动设计过程的。

The diagram on the top of the next page is a navigation map. It shows the patterns that will be presented in this section and a few of the ways they relate to each other.

> 下面的简图是一张导航图，它描述的是本部分所要讲解的模式以及这些模式彼此关联的方式。

Sharing these standard patterns brings order to the design and makes it easier for team members to understand each other’s work. Using standard patterns also adds to the UBIQUITOUS LANGUAGE, which all team members can use to discuss model and design decisions.

> 共用这些标准模式可以使设计有序进行，也使项目组成员能够更方便地了解彼此的工作内容。同时，使用标准模式也使UBIQUITOUS LANGUAGE更加丰富，所有的项目组成员都可以使用UBIQUITOUS LANGUAGE来讨论模型和设计决策。

Developing a good domain model is an art. But the practical design and implementation of a model’s individual elements can be relatively systematic. Isolating the domain design from the mass of other concerns in the software system will greatly clarify the design’s connection to the model. Defining model elements according to certain distinctions sharpens their meanings. Following proven patterns for individual elements helps produce a model that is practical to implement.

> 开发一个好的领域模型是一门艺术。而模型中各个元素的实际设计和实现则相对系统化。将领域设计与软件系统中的其他关注点分离会使设计与模型之间的关系非常清晰。根据不同的特征来定义模型元素则会使元素的意义更加鲜明。对每个元素使用已验证的模式有助于创建出更易于实现的模型。

Image
A navigation map of the language of MODEL-DRIVEN DESIGN

> MODEL-DRIVEN DESIGN语言的导航图

Elaborate models can cut through complexity only if care is taken with the fundamentals, resulting in detailed elements that the team can confidently combine.

> 只有在充分考虑这些基本原理之后，精心设计的模型才能化繁为简，创建出项目组成员可以放心地进行组合使用的详细元素。