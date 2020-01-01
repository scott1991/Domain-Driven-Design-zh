# 第 6 章 领域对象的生命周期

> Six. The Life Cycle of a Domain Object

Every object has a life cycle. An object is born, it likely goes through various states, and it eventually dies—being either archived or deleted. Of course, many of these are simple, transient objects, created with an easy call to their constructor, used in some computation, and then abandoned to the garbage collector. There is no need to complicate such objects. But other objects have longer lives, not all of which are spent in active memory. They have complex interdependencies with other objects. They go through changes of state to which invariants apply. Managing these objects presents challenges that can easily derail an attempt at MODEL-DRIVEN DESIGN.

> 每个对象都有生命周期，如图 6-1 所示。对象自创建后，可能会经历各种不同的状态，直至最终消亡——要么存档，要么删除。当然，很多对象是简单的临时对象，仅通过调用构造函数来创建，用来做一些计算，而后由垃圾收集器回收。这类对象没必要搞得那么复杂。但有些对象具有更长的生命周期，其中一部分时间不是在活动内存中度过的。它们与其他对象具有复杂的相互依赖性。它们会经历一些状态变化，在变化时要遵守一些固定规则。管理这些对象时面临诸多挑战，稍有不慎就会偏离 MODEL-DRIVEN DESIGN 的轨道。

<Figures figure="6-1">The life cycle of a domain object</Figures>

The challenges fall into two categories.

> 主要的挑战有以下两类。

1. Maintaining integrity throughout the life cycle
2. Preventing the model from getting swamped by the complexity of managing the life cycle

---

> 1. 在整个生命周期中维护完整性。
> 2. 防止模型陷入管理生命周期复杂性造成的困境当中。

This chapter will address these issues through three patterns. First, AGGREGATES tighten up the model itself by defining clear ownership and boundaries, avoiding a chaotic, tangled web of objects. This pattern is crucial to maintaining integrity in all phases of the life cycle.

> 本章将通过 3 种模式解决这些问题。首先是 AGGREGATE（聚合），它通过定义清晰的所属关系和边界，并避免混乱、错综复杂的对象关系网来实现模型的内聚。聚合模式对于维护生命周期各个阶段的完整性具有至关重要的作用。

Next, the focus turns to the beginning of the life cycle, using FACTORIES to create and reconstitute complex objects and AGGREGATES, keeping their internal structure encapsulated. Finally, REPOSITORIES address the middle and end of the life cycle, providing the means of finding and retrieving persistent objects while encapsulating the immense infrastructure involved.

> 接下来，我们将注意力转移到生命周期的开始阶段，使用 FACTORY（工厂）来创建和重建复杂对象和 AGGREGATE（聚合），从而封装它们的内部结构。最后，在生命周期的中间和末尾使用 REPOSITORY（存储库）来提供查找和检索持久化对象并封装庞大基础设施的手段。

Although REPOSITORIES and FACTORIES do not themselves come from the domain, they have meaningful roles in the domain design. These constructs complete the MODEL-DRIVEN DESIGN by giving us accessible handles on the model objects.

> 尽管 REPOSITORY 和 FACTORY 本身并不是来源于领域，但它们在领域设计中扮演着重要的角色。这些结构提供了易于掌握的模型对象处理方式，使 MODEL-DRIVEN DESIGN 更完备。

Modeling AGGREGATES and adding FACTORIES and REPOSITORIES to the design gives us the ability to manipulate the model objects systematically and in meaningful units throughout their life cycle. AGGREGATES mark off the scope within which invariants have to be maintained at every stage of the life cycle. FACTORIES and REPOSITORIES operate on AGGREGATES, encapsulating the complexity of specific life cycle transitions.

> 使用 AGGREGATE 进行建模，并且在设计中结合使用 FACTORY 和 REPOSITORY，这样我们就能够在模型对象的整个生命周期中，以有意义的单元、系统地操纵它们。AGGREGATE 可以划分出一个范围，这个范围内的模型元素在生命周期各个阶段都应该维护其固定规则。FACTORY 和 REPOSITORY 在 AGGREGATE 基础上进行操作，将特定生命周期转换的复杂性封装起来。

## 6.1 AGGREGATES 模式：AGGREGATE

![](/figures/ch6/06inf01.jpg)

Minimalist design of associations helps simplify traversal and limit the explosion of relationships somewhat, but most business domains are so interconnected that we still end up tracing long, deep paths through object references. In a way, this tangle reflects the realities of the world, which seldom obliges us with sharp boundaries. It is a problem in a software design.

> 减少设计中的关联有助于简化对象之间的遍历，并在某种程度上限制关系的急剧增多。但大多数业务领域中的对象都具有十分复杂的联系，以至于最终会形成很长、很深的对象引用路径，我们不得不在这个路径上追踪对象。在某种程度上，这种混乱状态反映了现实世界，因为现实世界中就很少有清晰的边界。但这却是软件设计中的一个重要问题。

Say you were deleting a Person object from a database. Along with the person go a name, birth date, and job description. But what about the address? There could be other people at the same address. If you delete the address, those Person objects will have references to a deleted object. If you leave it, you accumulate junk addresses in the database. Automatic garbage collection could eliminate the junk addresses, but that technical fix, even if available in your database system, ignores a basic modeling issue.

> 假设我们从数据库中删除一个 Person 对象。这个人的姓名、出生日期和工作描述要一起被删除，但要如何处理地址呢？可能还有其他人住在同一地址。如果删除了地址，那些 Person 对象将会引用一个被删除的对象。如果保留地址，那么垃圾地址在数据库中会累积起来。虽然自动垃圾收集机制可以清除垃圾地址，但这也只是一种技术上的修复；就算数据库系统存在这种处理机制，一个基本的建模问题依然被忽略了。

Even when considering an isolated transaction, the web of relationships in a typical object model gives no clear limit to the potential effect of a change. It is not practical to refresh every object in the system, just in case there is some dependency.

> 即便是在考虑孤立的事务时，典型对象模型中的关系网也使我们难以断定一个修改会产生哪些潜在的影响。仅仅因为存在依赖就更新系统中的每个对象，这样做是不现实的。

The problem is acute in a system with concurrent access to the same objects by multiple clients. With many users consulting and updating different objects in the system, we have to prevent simultaneous changes to interdependent objects. Getting the scope wrong has serious consequences.

> 在多个客户对相同对象进行并发访问的系统中，这个问题更加突出。当很多用户对系统中的对象进行查询和更新时，必须防止他们同时修改互相依赖的对象。范围错误将导致严重的后果。

It is difficult to guarantee the consistency of changes to objects in a model with complex associations. Invariants need to be maintained that apply to closely related groups of objects, not just discrete objects. Yet cautious locking schemes cause multiple users to interfere pointlessly with each other and make a system unusable.

> 在具有复杂关联的模型中，要想保证对象更改的一致性是很困难的。不仅互不关联的对象需要遵守一些固定规则，而且紧密关联的各组对象也要遵守一些固定规则。然而，过于谨慎的锁定机制又会导致多个用户之间毫无意义地互相干扰，从而使系统不可用。

Put another way, how do we know where an object made up of other objects begins and ends? In any system with persistent storage of data, there must be a scope for a transaction that changes data, and a way of maintaining the consistency of the data (that is, maintaining its invariants). Databases allow various locking schemes, and tests can be programmed. But these ad hoc solutions divert attention away from the model, and soon you are back to hacking and hoping.

> 换句话说，我们如何知道一个由其他对象组成的对象从哪里开始，又到何处结束呢？在任何具有持久化数据存储的系统中，对数据进行修改的事务必须要有范围，而且要有保持数据一致性的方式（也就是说，保持数据遵守固定规则）。数据库支持各种锁机制，而且可以编写一些测试来验证。但这些特殊的解决方案分散了人们对模型的注意力，很快人们就会回到“走一步，看一步”的老路上来。

In fact, finding a balanced solution to these kinds of problems calls for deeper understanding of the domain, this time extending to factors such as the frequency of change between the instances of certain classes. We need to find a model that leaves high-contention points looser and strict invariants tighter.

> 实际上，要想找到一种兼顾各种问题的解决方案，要求对领域有深刻的理解，例如，要了解特定类实例之间的更改频率这样的深层次因素。我们需要找到一个使对象间冲突较少而固定规则联系更紧密的模型

Although this problem surfaces as technical difficulties in database transactions, it is rooted in the model—in its lack of defined boundaries. A solution driven from the model will make the model easier to understand and make the design easier to communicate. As the model is revised, it will guide our changes to the implementation.

> 尽管从表面上看这个问题是数据库事务方面的一个技术难题，但它的根源却在模型，归根结底是由于模型中缺乏明确定义的边界。从模型得到的解决方案将使模型更易于理解，并且使设计更易于沟通。当模型被修改时，它将引导我们对实现做出修改。

Schemes have been developed for defining ownership relationships in the model. The following simple but rigorous system, distilled from those concepts, includes a set of rules for implementing transactions that modify the objects and their owners.1

> 人们已经开发出很多模式（scheme）来定义模型中的所属关系。下面这个简单但严格的系统就提炼自这些概念，其包括一组用于实现事务（这些事务用来修改对象及其所有者）的规则[插图]。

First we need an abstraction for encapsulating references within the model. An AGGREGATE is a cluster of associated objects that we treat as a unit for the purpose of data changes. Each AGGREGATE has a root and a boundary. The boundary defines what is inside the AGGREGATE. The root is a single, specific ENTITY contained in the AGGREGATE. The root is the only member of the AGGREGATE that outside objects are allowed to hold references to, although objects within the boundary may hold references to each other. ENTITIES other than the root have local identity, but that identity needs to be distinguishable only within the AGGREGATE, because no outside object can ever see it out of the context of the root ENTITY.

> 首先，我们需要用一个抽象来封装模型中的引用。AGGREGATE 就是一组相关对象的集合，我们把它作为数据修改的单元。每个 AGGREGATE 都有一个根（root）和一个边界（boundary）。边界定义了 AGGREGATE 的内部都有什么。根则是 AGGREGATE 所包含的一个特定 ENTITY。对 AGGREGATE 而言，外部对象只可以引用根，而边界内部的对象之间则可以互相引用。除根以外的其他 ENTITY 都有本地标识，但这些标识只在 AGGREGATE 内部才需要加以区别，因为外部对象除了根 ENTITY 之外看不到其他对象。

A model of a car might be used in software for an auto repair shop. The car is an ENTITY with global identity: we want to distinguish that car from all other cars in the world, even very similar ones. We can use the vehicle identification number for this, a unique identifier assigned to each new car. We might want to track the rotation history of the tires through the four wheel positions. We might want to know the mileage and tread wear of each tire. To know which tire is which, the tires must be identified ENTITIES also. But it is very unlikely that we care about the identity of those tires outside of the context of that particular car. If we replace the tires and send the old ones to a recycling plant, either our software will no longer track them at all, or they will become anonymous members of a heap of tires. No one will care about their rotation histories. More to the point, even while they are attached to the car, no one will try to query the system to find a particular tire and then see which car it is on. They will query the database to find a car and then ask it for a transient reference to the tires. Therefore, the car is the root ENTITY of the AGGREGATE whose boundary encloses the tires also. On the other hand, engine blocks have serial numbers engraved on them and are sometimes tracked independently of the car. In some applications, the engine might be the root of its own AGGREGATE.

> 汽车修配厂的软件可能会使用汽车模型。如图 6-2 所示。汽车是一个具有全局标识的 ENTITY：我们需要将这部汽车与世界上所有其他汽车区分开（即使是一些非常相似的汽车）。我们可以使用车辆识别号来进行区分，车辆识别号是为每辆新汽车分配的唯一标识符。我们可能想通过 4 个轮子的位臵跟踪轮胎的转动历史。我们可能想知道每个轮胎的里程数和磨损度。要想知道哪个轮胎在哪儿，必须将轮胎标识为 ENTITY。当脱离这辆车的上下文后，我们很可能就不再关心这些轮胎的标识了。如果更换了轮胎并将旧轮胎送到回收厂，那么软件将不再需要跟踪它们，它们会成为一堆废旧轮胎中的一部分。没有人会关心它们的转动历史。更重要的是，即使轮胎被安在汽车上，也不会有人通过系统查询特定的轮胎，然后看看这个轮胎在哪辆汽车上。人们只会在数据库中查找汽车，然后临时查看一下这部汽车的轮胎情况。因此，汽车是 AGGREGATE 的根 ENTITY，而轮胎处于这个 AGGREGATE 的边界之内。另一方面，发动机组上面都刻有序列号，而且有时是独立于汽车被跟踪的。在一些应用程序中，发动机可以是自己的 AGGREGATE 的根。

<Figures figure="6-2">Local versus global identity and object references</Figures>

Invariants, which are consistency rules that must be maintained whenever data changes, will involve relationships between members of the AGGREGATE. Any rule that spans AGGREGATES will not be expected to be up-to-date at all times. Through event processing, batch processing, or other update mechanisms, other dependencies can be resolved within some specified time. But the invariants applied within an AGGREGATE will be enforced with the completion of each transaction.

> 固定规则（invariant）是指在数据变化时必须保持的一致性规则，其涉及 AGGREGATE 成员之间的内部关系。而任何跨越 AGGREGATE 的规则将不要求每时每刻都保持最新状态。通过事件处理、批处理或其他更新机制，这些依赖会在一定的时间内得以解决。但在每个事务完成时，AGGREGATE 内部所应用的固定规则必须得到满足，如图 6-3 所示。

<Figures figure="6-3">AGGREGATE invariants</Figures>

Now, to translate that conceptual AGGREGATE into the implementation, we need a set of rules to apply to all transactions.

> 现在，为了实现这个概念上的 AGGREGATE，需要对所有事务应用一组规则。

- The root ENTITY has global identity and is ultimately responsible for checking invariants.
- Root ENTITIES have global identity. ENTITIES inside the boundary have local identity, unique only within the AGGREGATE.
- Nothing outside the AGGREGATE boundary can hold a reference to anything inside, except to the root ENTITY. The root ENTITY can hand references to the internal ENTITIES to other objects, but those objects can use them only transiently, and they may not hold on to the reference. The root may hand a copy of a VALUE OBJECT to another object, and it doesn’t matter what happens to it, because it’s just a VALUE and no longer will have any association with the AGGREGATE.
- As a corollary to the previous rule, only AGGREGATE roots can be obtained directly with database queries. All other objects must be found by traversal of associations.
- Objects within the AGGREGATE can hold references to other AGGREGATE roots.
- A delete operation must remove everything within the AGGREGATE boundary at once. (With garbage collection, this is easy. Because there are no outside references to anything but the root, delete the root and everything else will be collected.)
- When a change to any object within the AGGREGATE boundary is committed, all invariants of the whole AGGREGATE must be satisfied.

---

> - 根 ENTITY 具有全局标识，它最终负责检查固定规则。
> - 根 ENTITY 具有全局标识。边界内的 ENTITY 具有本地标识，这些标识只在 AGGREGATE 内部才是唯一的。
> - AGGREGATE 外部的对象不能引用除根 ENTITY 之外的任何内部对象。根 ENTITY 可以把对内部 ENTITY 的引用传递给它们，但这些对象只能临时使用这些引用，而不能保持引用。根可以把一个 VALUE OBJECT 的副本传递给另一个对象，而不必关心它发生什么变化，因为它只是一个 VALUE，不再与 AGGREGATE 有任何关联。
> - 作为上一条规则的推论，只有 AGGREGATE 的根才能直接通过数据库查询获取。所有其他对象必须通过遍历关联来发现。
> - AGGREGATE 内部的对象可以保持对其他 AGGREGATE 根的引用。
> - 删除操作必须一次删除 AGGREGATE 边界之内的所有对象。（利用垃圾收集机制，这很容易做到。由于除根以外的其他对象都没有外部引用，因此删除了根以后，其他对象均会被回收。）
> - 当提交对 AGGREGATE 边界内部的任何对象的修改时，整个 AGGREGATE 的所有固定规则都必须被满足。

Cluster the ENTITIES and VALUE OBJECTS into AGGREGATES and define boundaries around each. Choose one ENTITY to be the root of each AGGREGATE, and control all access to the objects inside the boundary through the root. Allow external objects to hold references to the root only. Transient references to internal members can be passed out for use within a single operation only. Because the root controls access, it cannot be blindsided by changes to the internals. This arrangement makes it practical to enforce all invariants for objects in the AGGREGATE and for the AGGREGATE as a whole in any state change.

> 我们应该将 ENTITY 和 VALUE OBJECT 分门别类地聚集到 AGGREGATE 中，并定义每个 AGGREGATE 的边界。在每个 AGGREGATE 中，选择一个 ENTITY 作为根，并通过根来控制对边界内其他对象的所有访问。只允许外部对象保持对根的引用。对内部成员的临时引用可以被传递出去，但仅在一次操作中有效。由于根控制访问，因此不能绕过它来修改内部对象。这种设计有利于确保 AGGREGATE 中的对象满足所有固定规则，也可以确保在任何状态变化时 AGGREGATE 作为一个整体满足固定规则。

It can be very helpful to have a technical framework that allows you to declare AGGREGATES and then automatically carries out the locking scheme and so forth. Without that assistance, the team must have the self-discipline to agree on the AGGREGATES and code consistently with them.

> 有一个能够声明 AGGREGATE 的技术框架是很有帮助的，这样就可以自动实施锁机制和其他一些功能。如果没有这样的技术框架，团队就必须靠自我约束来使用事先商定的 AGGREGATE，并按照这些 AGGREGATE 来编写代码。

Example: Purchase Order Integrity

> 示例采购订单的完整性

Consider the complications possible in a simplified purchase order system.

> 考虑一个简化的采购订单系统（见图 6-4）可能具有的复杂性。

<Figures figure="6-4">A model for a purchase order system</Figures>

This diagram presents a pretty conventional view of a purchase order (PO), broken down into line items, with an invariant rule that the sum of the line items can’t exceed the limit for the PO as a whole. The existing implementation has three interrelated problems.

> 图 6-4 展示了一个典型的采购订单（Purchase Order, PO）视图，它被分解为采购项（LineItem），一条固定规则是采购项的总量不能超过 PO 总额的限制。当前实现存在以下 3 个互相关联的问题。

1. Invariant enforcement. When a new line item is added, the PO checks the total and marks itself invalid if an item pushes it over the limit. As we’ll see, this is not adequate protection.
2. Change management. When the PO is deleted or archived, the line items are taken along, but the model gives no guidance on where to stop following the relationships. There is also confusion about the impact of changing the part price at different times.
3. Sharing the database. Multiple users are creating contention problems in the database.

---

> 1. 固定规则的实施。当添加新采购项时，PO 检查总额，如果新增的采购项使总额超出限制，则将 PO 标记为无效。正如我们将要看到的那样，这种保护机制并不充分。
> 2. 变更管理。当 PO 被删除或存档时，各个采购项也将被一块处理，但模型并没有给出关系应该在何处停止。在不同时间更改部件（Part）价格所产生的影响也不明确。
> 3. 数据库共享。数据库会出现由于多个用户竞争使用而带来的问题。

Multiple users will be entering and updating various POs concurrently, and we have to prevent them from messing up each other’s work. Let’s start with a very simple strategy, in which we lock any object a user begins to edit until that user commits the transaction. So, when George is editing line item 001, Amanda cannot access it. She can edit any other line item on any other PO (including other items in the PO George is working on).

> 多个用户将并发地输入和更新各个 PO，因此必须防止他们互相干扰。让我们从一个非常简单的策略开始，当一个用户开始编辑任何一个对象时，锁定该对象，直到用户提交事务。这样，当 George 编辑采购项 001 时，Amanda 就无法访问该项。Amanda 可以编辑其他 PO 上的任何采购项（包括 George 正在编辑的 PO 上的其他采购项），如图 6-5 所示。

<Figures figure="6-5">The initial condition of the PO stored in the database</Figures>

Objects will be read from the database and instantiated in each user’s memory space. There they can be viewed and edited. Database locks will be requested only when an edit begins. So both George and Amanda can work concurrently, as long as they stay away from each other’s items. All is well . . . until both George and Amanda start working on separate line items in the same PO.

> 每个用户都将从数据库读取对象，并在自己的内存空间中实例化对象，而后在那里查看和编辑对象。只有当开始编辑时，才会请求进行数据库锁定。因此，George 和 Amanda 可以同时工作，只要他们不同时编辑相同的采购项即可。一切正常，直到 George 和 Amanda 开始编辑同一个 PO 上的不同采购项，如图 6-6 所示。

<Figures figure="6-6">Simultaneous edits in distinct transactions</Figures>

Everything looks fine to both users and to their software because they ignore changes to other parts of the database that happen during the transaction, and neither locked line item is involved in the other user’s change.

> 从这两个用户和他们各自软件的角度来看，他们的操作都没有问题，因为他们忽略了事务期间数据库其他部分所发生的变化，而且每个用户都没有修改被对方锁定的采购项。

<Figures figure="6-7">The resulting PO violates the approval limit (broken invariant).</Figures>

After both users have saved their changes, a PO is stored in the database that violates the invariant of the domain model. An important business rule has been broken. And nobody even knows.

> 当这两个用户保存了修改之后，数据库中就存储了一个违反领域模型固定规则的 PO。一条重要的业务规则被破坏了，但并没有人知道，如图 6-7 所示。

Clearly, locking a single line item isn’t an adequate safeguard. If instead we had locked an entire PO at a time, the problem would have been prevented.

> 显然，锁定单个行并不是一种充分的保护机制。如果一次锁定一个 PO，可以防止这样的问题发生，如图 6-8 所示。

<Figures figure="6-8">Locking the entire PO allows the invariant to be enforced.</Figures>

The program will not allow this transaction to be saved until Amanda has resolved the problem, perhaps by raising the limit or by eliminating a guitar. This mechanism prevents the problem, and it may be a fine solution if work is mostly spread widely across many POs. But if multiple people typically work simultaneously on different line items of a large PO, then this locking will get cumbersome.

> 直到 Amanda 解决这个问题之前，程序将不允许保存这个事务，Amanda 可以通过提高限额或减少一把吉他来解决此问题。这种机制防止了问题，如果大部分工作分布在多个 PO 上，那么这可能是个不错的解决方案。但如果是很多人同时对一个大 PO 的不同项进行操作时，这种锁定机制就显得很笨拙了。

Even assuming many small POs, there are other ways to violate the assertion. Consider that “part.” If someone changed the price of a trombone while Amanda was adding to her order, wouldn’t that violate the invariant too?

> 即便是很多小 PO，也存在其他方法破坏这条固定规则。让我们看看“Part”。如果在 Amanda 将长号加入订单时，有人更改了长号的价格，这不也会破坏固定规则吗？

Let’s try locking the part in addition to the entire PO. Here’s what happens when George, Amanda, and Sam are working on different POs:

> 那么，我们试着除了锁定整个 PO 之外，也锁定 Part。图 6-9 展示了当 George、Amanda 和 Sam 在不同 PO 上工作时将会发生的情况。

<Figures figure="6-9">Over-cautious locking is interfering with people’s work.</Figures>

The inconvenience is mounting, because there is a lot of contention for the instruments (the “parts”). And then:

> 工作变得越来越麻烦，因为在 Part 上出现了很多争用的情况。这样就会发生图 6-10 中的结果：

<Figures figure="6-10">Deadlock</Figures>

Those three will be waiting a while.

> 3 个人都需要等待。

At this point we can begin to improve the model by incorporating the following knowledge of the business:

> 现在我们可以开始改进模型，在模型中加入以下业务知识。

1. Parts are used in many POs (high contention).
2. There are fewer changes to parts than there are to POs.
3. Changes to part prices do not necessarily propagate to existing POs. It depends on the time of a price change relative to the status of the PO.

---

> 1. Part 在很多 PO 中使用（会产生高竞争）。
> 2. 对 Part 的修改少于对 PO 的修改。
> 3. 对 Price（价格）的修改不一定要传播到现有 PO，它取决于修改价格时 PO 处于什么状态。

Point 3 is particularly obvious when we consider archived POs that have already been delivered. They should, of course, show the prices as of the time they were filled, rather than current prices.

> 当考虑已经交货并存档的 PO 时，第三点尤为明显。它们显示的当然是填写时的价格，而不是当前价格。

<Figures figure="6-11">Price is copied into Line Item. AGGREGATE invariant can now be enforced.</Figures>

An implementation consistent with this model would guarantee the invariant relating PO and its items, while changes to the price of a part would not have to immediately affect the items that reference it. Broader consistency rules could be addressed in other ways. For example, the system could present a queue of items with outdated prices to the users each day, so they could update or exempt each one. But this is not an invariant that must be enforced at all times. By making the dependency of line items on parts looser, we avoid contention and reflect the realities of the business better. At the same time, tightening the relationship of the PO and its line items guarantees that an important business rule will be followed.

> 按照图 6-11，这个模型得到的实现可以确保满足 PO 和采购项相关的固定规则，同时，修改部件的价格将不会立即影响引用部件的采购项。涉及面更广的规则可以通过其他方式来满足。例如，系统可以每天为用户列出价格过期的采购项，这样用户就可以决定是更新还是去掉采购项。但这并不是必须一直保持的固定规则。通过减少采购项对 Part 的依赖，可以避免争用，并且能够更好地反映出业务的现实情况。同时，加强 PO 与采购项之间的关系可以确保遵守这条重要的业务规则。

The AGGREGATE imposes an ownership of the PO and its items that is consistent with business practice. The creation and deletion of a PO and items are naturally tied together, while the creation and deletion of parts is independent.

> AGGREGATE 强制了 PO 与采购项之间符合业务实际的所属关系。PO 和采购项的创建及删除很自然地被联系在一起，而 Part 的创建和删除却是独立的。

---

AGGREGATES mark off the scope within which invariants have to be maintained at every stage of the life cycle. The following patterns, FACTORIES and REPOSITORIES, operate on AGGREGATES, encapsulating the complexity of specific life cycle transitions. . . .

> AGGREGATE 划分出一个范围，在这个范围内，生命周期的每个阶段都必须满足一些固定规则。接下来要讨论的两种模式 FACTORY 和 REPOSITORY 都是在 AGGREGATE 上执行操作，它们将特定生命周期转换的复杂性封装起来……

## 6.2 FACTORIES 模式：FACTORY

![](/figures/ch6/06inf02.jpg)

When creation of an object, or an entire AGGREGATE, becomes complicated or reveals too much of the internal structure, FACTORIES provide encapsulation.

> 当创建一个对象或创建整个 AGGREGATE 时，如果创建工作很复杂，或者暴露了过多的内部结构，则可以使用 FACTORY 进行封装。

---

Much of the power of objects rests in the intricate configuration of their internals and their associations. An object should be distilled until nothing remains that does not relate to its meaning or support its role in interactions. This mid-life cycle responsibility is plenty. Problems arise from overloading a complex object with responsibility for its own creation.

> 对象的功能主要体现在其复杂的内部配臵以及关联方面。我们应该一直对对象进行提炼，直到所有与其意义或在交互中的角色无关的内容被完全剔除为止。一个对象在它的生命周期中要承担大量职责。如果再让复杂对象负责自身的创建，那么职责过载将会导致问题。

A car engine is an intricate piece of machinery, with dozens of parts collaborating to perform the engine’s responsibility: to turn a shaft. One could imagine trying to design an engine block that could grab on to a set of pistons and insert them into its cylinders, spark plugs that would find their sockets and screw themselves in. But it seems unlikely that such a complicated machine would be as reliable or as efficient as our typical engines are. Instead, we accept that something else will assemble the pieces. Perhaps it will be a human mechanic or perhaps it will be an industrial robot. Both the robot and the human are actually more complex than the engine they assemble. The job of assembling parts is completely unrelated to the job of spinning a shaft. The assemblers function only during the creation of the car—you don’t need a robot or a mechanic with you when you’re driving. Because cars are never assembled and driven at the same time, there is no value in combining both of these functions into the same mechanism. Likewise, assembling a complex compound object is a job that is best separated from whatever job that object will have to do when it is finished.

> 汽车发动机是一种复杂的机械装臵，它由数十个零件共同协作来履行发动机的职责——使轴转动。我们可以试着设计一种发动机组，让它自己抓取一组活塞并塞到汽缸中，火花塞也可以自己找到插孔并把自己拧进去。但这样组装的复杂机器可能没有我们常见的发动机那样可靠或高效。相反，我们用其他东西来装配发动机。或许是机械师，或者是工业机器人。无论是机器人还是人，实际上都比二者要装配的发动机复杂。装配零件的工作与使轴旋转的工作完全无关。只是在生产汽车时才需要装配工，我们驾驶时并不需要机器人或机械师。由于汽车的装配和驾驶永远不会同时发生，因此将这两种功能合并到同一个机制中是毫无价值的。同理，装配复杂的复合对象的工作也最好与对象要执行的工作分开。

But shifting responsibility to the other interested party, the client object in the application, leads to even worse problems. The client knows what job needs to be done and relies on the domain objects to carry out the necessary computations. If the client is expected to assemble the domain objects it needs, it must know something about the internal structure of the object. In order to enforce all the invariants that apply to the relationship of parts in the domain object, the client must know some of the object’s rules. Even calling constructors couples the client to the concrete classes of the objects it is building. No change to the implementation of the domain objects can be made without changing the client, making refactoring harder.

> 但将职责转交给另一个相关方——应用程序中的客户（client）对象——会产生更严重的问题。客户知道需要完成什么工作，并依靠领域对象来执行必要的计算。如果指望客户来装配它需要的领域对象，那么它必须要了解一些对象的内部结构。为了确保所有应用于领域对象各部分关系的固定规则得到满足，客户必须知道对象的一些规则。甚至调用构造函数也会使客户与所要构建的对象的具体类产生耦合。结果是，对领域对象实现所做的任何修改都要求客户做出相应修改，这使得重构变得更加困难。

A client taking on object creation becomes unnecessarily complicated and blurs its responsibility. It breaches the encapsulation of the domain objects and the AGGREGATES being created. Even worse, if the client is part of the application layer, then responsibilities have leaked out of the domain layer altogether. This tight coupling of the application to the specifics of the implementation strips away most of the benefits of abstraction in the domain layer and makes continuing changes ever more expensive.

> 当客户负责创建对象时，它会牵涉不必要的复杂性，并将其职责搞得模糊不清。这违背了领域对象及所创建的 AGGREGATE 的封装要求。更严重的是，如果客户是应用层的一部分，那么职责就会从领域层泄漏到应用层中。应用层与实现细节之间的这种耦合使得领域层抽象的大部分优势荡然无存，而且导致后续更改的代价变得更加高昂。

Creation of an object can be a major operation in itself, but complex assembly operations do not fit the responsibility of the created objects. Combining such responsibilities can produce ungainly designs that are hard to understand. Making the client direct construction muddies the design of the client, breaches encapsulation of the assembled object or AGGREGATE, and overly couples the client to the implementation of the created object.

> 对象的创建本身可以是一个主要操作，但被创建的对象并不适合承担复杂的装配操作。将这些职责混在一起可能产生难以理解的拙劣设计。让客户直接负责创建对象又会使客户的设计陷入混乱，并且破坏被装配对象或 AGGREGATE 的封装，而且导致客户与被创建对象的实现之间产生过于紧密的耦合。

Complex object creation is a responsibility of the domain layer, yet that task does not belong to the objects that express the model. There are some cases in which an object creation and assembly corresponds to a milestone significant in the domain, such as “open a bank account.” But object creation and assembly usually have no meaning in the domain; they are a necessity of the implementation. To solve this problem, we have to add constructs to the domain design that are not ENTITIES, VALUE OBJECTS, or SERVICES. This is a departure from the previous chapter, and it is important to make the point clear: We are adding elements to the design that do not correspond to anything in the model, but they are nonetheless part of the domain layer’s responsibility.

> 复杂的对象创建是领域层的职责，然而这项任务并不属于那些用于表示模型的对象。在有些情况下，对象的创建和装配对应于领域中的重要事件，如“开立银行账户”。但一般情况下，对象的创建和装配在领域中并没有什么意义，它们只不过是实现的一种需要。为了解决这一问题，我们必须在领域设计中增加一种新的构造，它不是 ENTITY、VALUE OBJECT，也不是 SERVICE。这与前一章的论述相违背，因此把它解释清楚很重要。我们正在向设计中添加一些新元素，但它们不对应于模型中的任何事物，而确实又承担领域层的部分职责。

Every object-oriented language provides a mechanism for creating objects (constructors in Java and C++, instance creation class methods in Smalltalk, for example), but there is a need for more abstract construction mechanisms that are decoupled from the other objects. A program element whose responsibility is the creation of other objects is called a FACTORY.

> 每种面向对象的语言都提供了一种创建对象的机制（例如，Java 和 C++中的构造函数，Smalltalk 中创建实例的类方法），但我们仍然需要一种更加抽象且不与其他对象发生耦合的构造机制。这就是 FACTORY，它是一种负责创建其他对象的程序元素。如图 6-12 所示。

<Figures figure="6-12">Basic interactions with a FACTORY</Figures>

Just as the interface of an object should encapsulate its implementation, thus allowing a client to use the object’s behavior without knowing how it works, a FACTORY encapsulates the knowledge needed to create a complex object or AGGREGATE. It provides an interface that reflects the goals of the client and an abstract view of the created object.

> 正如对象的接口应该封装对象的实现一样（从而使客户无需知道对象的工作机理就可以使用对象的功能），FACTORY 封装了创建复杂对象或 AGGREGATE 所需的知识。它提供了反映客户目标的接口，以及被创建对象的抽象视图。

Therefore:

> 因此：

Shift the responsibility for creating instances of complex objects and AGGREGATES to a separate object, which may itself have no responsibility in the domain model but is still part of the domain design. Provide an interface that encapsulates all complex assembly and that does not require the client to reference the concrete classes of the objects being instantiated. Create entire AGGREGATES as a piece, enforcing their invariants.

> 应该将创建复杂对象的实例和 AGGREGATE 的职责转移给单独的对象，这个对象本身可能没有承担领域模型中的职责，但它仍是领域设计的一部分。提供一个封装所有复杂装配操作的接口，而且这个接口不需要客户引用要被实例化的对象的具体类。在创建 AGGREGATE 时要把它作为一个整体，并确保它满足固定规则。

---

There are many ways to design FACTORIES. Several special-purpose creation patterns—FACTORY METHOD, ABSTRACT FACTORY, and BUILDER—were thoroughly treated in Gamma et al. 1995. That book mostly explored patterns for the most difficult object construction problems. The point here is not to delve deeply into designing FACTORIES, but rather to show the place of FACTORIES as important components of a domain design. Proper use of FACTORIES can help keep a MODEL-DRIVEN DESIGN on track.

> FACTORY 有很多种设计方式。[Gamma et al. 1995]中详尽论述了几种特定目的的创建模式，包括 FACTORY METHOD（工厂方法）、ABSTRACT FACTORY（抽象工厂）和 BUILDER（构建器）。该书主要研究了适用于最复杂的对象构造问题的模式。本书的重点并不是深入讨论 FACTORY 的设计问题，而是要表明 FACTORY 的重要地位——它是领域设计的重要组件。正确使用 FACTORY 有助于保证 MODEL-DRIVEN DESIGN 沿正确的轨道前进。

The two basic requirements for any good FACTORY are

> 任何好的工厂都需满足以下两个基本需求。

1. Each creation method is atomic and enforces all invariants of the created object or AGGREGATE. A FACTORY should only be able to produce an object in a consistent state. For an ENTITY, this means the creation of the entire AGGREGATE, with all invariants satisfied, but probably with optional elements still to be added. For an immutable VALUE OBJECT, this means that all attributes are initialized to their correct final state. If the interface makes it possible to request an object that can’t be created correctly, then an exception should be raised or some other mechanism should be invoked that will ensure that no improper return value is possible.
2. The FACTORY should be abstracted to the type desired, rather than the concrete class(es) created. The sophisticated FACTORY patterns in Gamma et al. 1995 help with this.

---

> 1. 每个创建方法都是原子的，而且要保证被创建对象或 AGGREGATE 的所有固定规则。FACTORY 生成的对象要处于一致的状态。在生成 ENTITY 时，这意味着创建满足所有固定规则的整个 AGGREGATE，但在创建完成后可以向聚合添加可选元素。在创建不变的 VALUE OBJECT 时，这意味着所有属性必须被初始化为正确的最终状态。如果 FACTORY 通过其接口收到了一个创建对象的请求，而它又无法正确地创建出这个对象，那么它应该抛出一个异常，或者采用其他机制，以确保不会返回错误的值。
> 2. FACTORY 应该被抽象为所需的类型，而不是所要创建的具体类。[Gamma et al. 1995]中的高级 FACTORY 模式介绍了这一话题。

### 6.2.1 Choosing FACTORIES and Their Sites 选择 FACTORY 及其应用位置

Generally speaking, you create a factory to build something whose details you want to hide, and you place the FACTORY where you want the control to be. These decisions usually revolve around AGGREGATES.

> 一般来说，FACTORY 的作用是隐藏创建对象的细节，而且我们把 FACTORY 用在那些需要隐藏细节的地方。这些决定通常与 AGGREGATE 有关。

For example, if you needed to add elements inside a preexisting AGGREGATE, you might create a FACTORY METHOD on the root of the AGGREGATE. This hides the implementation of the interior of the AGGREGATE from any external client, while giving the root responsibility for ensuring the integrity of the AGGREGATE as elements are added, as shown in Figure 6.13 on the next page.

> 例如，如果需要向一个已存在的 AGGREGATE 添加元素，可以在 AGGREGATE 的根上创建一个 FACTORY METHOD。这样就可以把 AGGREGATE 的内部实现细节隐藏起来，使任何外部客户看不到这些细节，同时使根负责确保 AGGREGATE 在添加元素时的完整性，如图 6-13 所示。

<Figures figure="6-13">A FACTORY METHOD encapsulates expansion of an AGGREGATE.</Figures>

Another example would be to place a FACTORY METHOD on an object that is closely involved in spawning another object, although it doesn’t own the product once it is created. When the data and possibly the rules of one object are very dominant in the creation of an object, this saves pulling information out of the spawner to be used elsewhere to create the object. It also communicates the special relationship between the spawner and the product.

> 另一个示例是在一个对象上使用 FACTORY METHOD，这个对象与生成另一个对象密切相关，但它并不拥有所生成的对象。当一个对象的创建主要使用另一个对象的数据（或许还有规则）时，则可以在后者的对象上创建一个 FACTORY METHOD，这样就不必将后者的信息提取到其他地方来创建前者。这样做还有利于表达前者与后者之间的关系。

In Figure 6.14, the Trade Order is not part of the same AGGREGATE as the Brokerage Account because, for a start, it will go on to interact with the trade execution application, where the Brokerage Account would only be in the way. Even so, it seems natural to give the Brokerage Account control over the creation of Trade Orders. The Brokerage Account contains information that will be embedded in the Trade Order (starting with its own identity), and it contains rules that govern what trades are allowed. We might also benefit from hiding the implementation of Trade Order. For example, it might be refactored into a hierarchy, with separate subclasses for Buy Order and Sell Order. The FACTORY keeps the client from being coupled to the concrete classes.

> 在图 6-14 中，Trade Order 不属于 Brokerage Account 所在的 AGGREGATE，因为它从一开始就与交易执行应用程序进行交互，所以把它放在 Brokerage Account 中只会碍事。尽管如此，让 Brokerage Account 负责控制 Trade Order 的创建却是很自然的事情。Brokerage Account 含有会被嵌入到 Trade Order 中的信息（从自己的标识开始），而且它还包含与交易相关的规则——这些规则控制了哪些交易是允许的。隐藏 Trade Order 的实现细节还会带来一些其他好处。例如，我们可以将它重构为一个层次结构，分别为 Buy Order 和 Sell Order 创建一些子类。FACTORY 可以避免客户与具体类之间产生耦合。

<Figures figure="6-14">A FACTORY METHOD spawns an ENTITY that is not part of the same AGGREGATE.</Figures>

A FACTORY is very tightly coupled to its product, so a FACTORY should be attached only to an object that has a close natural relationship with the product. When there is something we want to hide—either the concrete implementation or the sheer complexity of construction—yet there doesn’t seem to be a natural host, we must create a dedicated FACTORY object or SERVICE. A standalone FACTORY usually produces an entire AGGREGATE, handing out a reference to the root, and ensuring that the product AGGREGATE’S invariants are enforced. If an object interior to an AGGREGATE needs a FACTORY, and the AGGREGATE root is not a reasonable home for it, then go ahead and make a standalone FACTORY. But respect the rules limiting access within an AGGREGATE, and make sure there are only transient references to the product from outside the AGGREGATE.

> FACTORY 与被构建对象之间是紧密耦合的，因此 FACTORY 应该只被关联到与被构建对象有着密切联系的对象上。当有些细节需要隐藏（无论要隐藏的是具体实现还是构造的复杂性）而又找不到合适的地方来隐藏它们时，必须创建一个专用的 FACTORY 对象或 SERVICE。整个 AGGREGATE 通常由一个独立的 FACTORY 来创建，FACTORY 负责把对根的引用传递出去，并确保创建出的 AGGREGATE 满足固定规则。如果 AGGREGATE 内部的某个对象需要一个 FACTORY，而这个 FACTORY 又不适合在 AGGREGATE 根上创建，那么应该构建一个独立的 FACTORY。但仍应遵守规则——把访问限制在 AGGREGATE 内部，并确保从 AGGREGATE 外部只能对被构建对象进行临时引用，如图 6-15 所示。

<Figures figure="6-15">A standalone FACTORY builds AGGREGATE.</Figures>

### 6.2.2 When a Constructor Is All You Need 有些情况下只需使用构造函数

I’ve seen far too much code in which all instances are created by directly calling class constructors, or whatever the primitive level of instance creation is for the programming language. The introduction of FACTORIES has great advantages, and is generally underused. Yet there are times when the directness of a constructor makes it the best choice. FACTORIES can actually obscure simple objects that don’t use polymorphism.

> 我曾经在很多代码中看到所有实例都是通过直接调用类构造函数来创建的，或者是使用编程语言的最基本的实例创建方式。FACTORY 的引入提供了巨大的优势，而这种优势往往并未得到充分利用。但是，在有些情况下直接使用构造函数确实是最佳选择。FACTORY 实际上会使那些不具有多态性的简单对象复杂化。

The trade-offs favor a bare, public constructor in the following circumstances.

> 在以下情况下最好使用简单的、公共的构造函数。

- The class is the type. It is not part of any interesting hierarchy, and it isn’t used polymorphically by implementing an interface.
- The client cares about the implementation, perhaps as a way of choosing a STRATEGY.
- All of the attributes of the object are available to the client, so that no object creation gets nested inside the constructor exposed to the client.
- The construction is not complicated.
- A public constructor must follow the same rules as a FACTORY: It must be an atomic operation that satisfies all invariants of the created object.

---

> - 类（class）是一种类型（type）。它不是任何相关层次结构的一部分，而且也没有通过接口实现多态性。
> - 客户关心的是实现，可能是将其作为选择 STRATEGY 的一种方式。
> - 客户可以访问对象的所有属性，因此向客户公开的构造函数中没有嵌套的对象创建。
> - 构造并不复杂。
> - 公共构造函数必须遵守与 FACTORY 相同的规则：它必须是原子操作，而且要满足被创建对象的所有固定规则。

Avoid calling constructors within constructors of other classes. Constructors should be dead simple. Complex assemblies, especially of AGGREGATES, call for FACTORIES. The threshold for choosing to use a little FACTORY METHOD isn’t high.

> 不要在构造函数中调用其他类的构造函数。构造函数应该保持绝对简单。复杂的装配，特别是 AGGREGATE，需要使用 FACTORY。使用 FACTORY METHOD 的门槛并不高。

The Java class library offers interesting examples. All collections implement interfaces that decouple the client from the concrete implementation. Yet they are all created by direct calls to constructors. A FACTORY could have encapsulated the collection hierarchy. The FACTORY’s methods could have allowed a client to ask for the features it needed, with the FACTORY selecting the appropriate class to instantiate. Code that created collections would be more expressive, and new collection classes could be installed without breaking every Java program.

> Java 类库提供了一些有趣的例子。所有集合都实现了接口，接口使得客户与具体实现之间不产生耦合。然而，它们都是通过直接调用构造函数创建的。但是，集合类本来是可以使用 FACTORY 来封装集合的层次结构的。而且，客户也可以使用 FACTORY 的方法来请求所需的特性，然后由 FACTORY 来选择适当的类来实例化。这样一来，创建集合的代码就会有更强的表达力，而且新增集合类时不会破坏现有的 Java 程序。

But there is a case in favor of the concrete constructors. First, the choice of implementation can be performance sensitive for many applications, so an application might want control. (Even so, a really smart FACTORY could accommodate such factors.) Anyway, there aren’t very many collection classes, so it isn’t that complicated to choose.

> 但在某些场合下使用具体的构造函数更为合适。首先，在很多应用程序中，实现方式的选择对性能的影响是非常敏感的，因此应用程序需要控制选择哪种实现（尽管如此，真正智能的 FACTORY 仍然可以满足这些因素的要求）。不管怎样，集合类的数量并不多，因此选择并不复杂。

The abstract collection types preserve some value in spite of the lack of a FACTORY because of their usage patterns. Collections are very often created in one place and used in another. This means that the client that ultimately uses the collection—adding, removing, and retrieving its contents—can still talk to the interface and be decoupled from the implementation. The selection of a collection class typically falls to the object that owns the collection, or to the owning object’s FACTORY.

> 虽然没有使用 FACTORY，但抽象集合类型仍然具有一定价值，原因就在于它们的使用模式。集合通常都是在一个地方创建，而在其他地方使用。这意味着最终使用集合（添加、删除和检索其内容）的客户仍可以与接口进行对话，从而不与实现发生耦合。集合类的选择通常由拥有该集合的对象来决定，或是由该对象的 FACTORY 来决定。

### 6.2.3 Designing the Interface 接口的设计

When designing the method signature of a FACTORY, whether standalone or FACTORY METHOD, keep in mind these two points.

> 当设计 FACTORY 的方法签名时，无论是独立的 FACTORY 还是 FACTORY METHOD，都要记住以下两点。

- Each operation must be atomic. You have to pass in everything needed to create a complete product in a single interaction with the FACTORY. You also have to decide what will happen if creation fails, in the event that some invariant isn’t satisfied. You could throw an exception or just return a null. To be consistent, consider adopting a coding standard for failures in FACTORIES.
- The FACTORY will be coupled to its arguments. If you are not careful in your selection of input parameters, you can create a rat’s nest of dependencies. The degree of coupling will depend on what you do with the argument. If it is simply plugged into the product, you’ve created a modest dependency. If you are picking parts out of the argument to use in the construction, the coupling gets tighter.

---

> - 每个操作都必须是原子的。我们必须在与 FACTORY 的一次交互中把创建对象所需的所有信息传递给 FACTORY。同时必须确定当创建失败时将执行什么操作，比如某些固定规则没有被满足。可以抛出一个异常或仅仅返回 null。为了保持一致，可以考虑采用编码标准来处理所有 FACTORY 的失败。
> - Factory 将与其参数发生耦合。如果在选择输入参数时不小心，可能会产生错综复杂的依赖关系。耦合程度取决于对参数（argument）的处理。如果只是简单地将参数插入到要构建的对象中，则依赖度是适中的。如果从参数中选出一部分在构造对象时使用，耦合将更紧密。

The safest parameters are those from a lower design layer. Even within a layer, there tend to be natural strata with more basic objects that are used by higher level objects. (Such layering will be discussed in different ways in Chapter 10, “Supple Design,” and again in Chapter 16, “Large-Scale Structure.”)

> 最安全的参数是那些来自较低设计层的参数。即使在同一层中，也有一种自然的分层倾向，其中更基本的对象被更高层的对象使用（第 10 章将从不同方面讨论这样的分层，第 16 章也会论述这个问题）。

Another good choice of parameter is an object that is closely related to the product in the model, so that no new dependency is being added. In the earlier example of a Purchase Order Item, the FACTORY METHOD takes a Catalog Part as an argument, which is an essential association for the Item. This adds a direct dependency between the Purchase Order class and the Part. But these three objects form a close conceptual group. The Purchase Order’s AGGREGATE already referenced the Part, anyway. So giving control to the AGGREGATE root and encapsulating the AGGREGATE’S internal structure is a good trade-off.

> 另一个好的参数选择是模型中与被构建对象密切相关的对象，这样不会增加新的依赖。在前面的 Purchase Order Item 示例中，FACTORY METHOD 将 Catalog Part 作为一个参数，它是 Item 的一个重要的关联。这在 Purchase Order 类和 Part 之间增加了直接依赖。但这 3 个对象组成了一个关系密切的概念小组。不管怎样，Purchase Order 的 AGGREGATE 已经引用了 Part。因此将控制权交给 AGGREGATE 根，并封装 AGGREGATE 的内部结构是一个不错的折中选择。

Use the abstract type of the arguments, not their concrete classes. The FACTORY is coupled to the concrete class of the products; it does not need to be coupled to concrete parameters also.

> 使用抽象类型的参数，而不是它们的具体类。FACTORY 与被构建对象的具体类发生耦合，而无需与具体的参数发生耦合。

### 6.2.4 Where Does Invariant Logic Go? 固定规则的相关逻辑应放置在哪里

A FACTORY is responsible for ensuring that all invariants are met for the object or AGGREGATE it creates; yet you should always think twice before removing the rules applying to an object outside that object. The FACTORY can delegate invariant checking to the product, and this is often best.

> FACTORY 负责确保它所创建的对象或 AGGREGATE 满足所有固定规则，然而在把应用于一个对象的规则移到该对象外部之前应三思。FACTORY 可以将固定规则的检查工作委派给被创建对象，而且这通常是最佳选择。

But FACTORIES have a special relationship with their products. They already know their product’s internal structure, and their entire reason for being involves the implementation of their product. Under some circumstances, there are advantages to placing invariant logic in the FACTORY and reducing clutter in the product. This is especially appealing with AGGREGATE rules (which span many objects). It is especially unappealing with FACTORY METHODS attached to other domain objects.

> 但 FACTORY 与被创建对象之间存在一种特殊关系。FACTORY 已经知道被创建对象的内部结构，而且创建 FACTORY 的目的与被创建对象的实现有着密切的联系。在某些情况下，把固定规则的相关逻辑放到 FACTORY 中是有好处的，这样可以让被创建对象的职责更明晰。对于 AGGREGATE 规则来说尤其如此（这些规则会约束很多对象）。但固定规则的相关逻辑却特别不适合放到那些与其他领域对象关联的 FACTORY METHOD 中。

Although in principle invariants apply at the end of every operation, often the transformations allowed to the object can never bring them into play. There might be a rule that applies to the assignment of the identity attributes of an ENTITY. But after creation that identity is immutable. VALUE OBJECTS are completely immutable. An object doesn’t need to carry around logic that will never be applied in its active lifetime. In such cases, the FACTORY is a logical place to put invariants, keeping the product simpler.

> 虽然原则上在每个操作结束时都应该应用固定规则，但通常对象所允许的转换可能永远也不会用到这些规则。可能 ENTITY 标识属性的赋值需要满足一条固定规则。但该标识在创建后可能一直保持不变。VALUE OBJECT 则是完全不变的。如果逻辑在对象的有效生命周期内永远也不被用到，那么对象就没有必要携带这个逻辑。在这种情况下，FACTORY 是放臵固定规则的合适地方，这样可以使 FACTORY 创建出的对象更简单。

### 6.2.5 ENTITY FACTORIES Versus VALUE OBJECT FACTORIES ENTITY FACTORY 与 VALUE OBJECT FACTORY

ENTITY FACTORIES differ from VALUE OBJECT FACTORIES in two ways. VALUE OBJECTS are immutable; the product comes out complete in its final form. So the FACTORY operations have to allow for a full description of the product. ENTITY FACTORIES tend to take just the essential attributes required to make a valid AGGREGATE. Details can be added later if they are not required by an invariant.

> ENTITY FACTORY 与 VALUE OBJECT FACTORY 有两个方面的不同。由于 VALUE OBJECT 是不可变的，因此，FACTORY 所生成的对象就是最终形式。因此 FACTORY 操作必须得到被创建对象的完整描述。而 ENTITY FACTORY 则只需具有构造有效 AGGREGATE 所需的那些属性。对于固定规则不关心的细节，可以之后再添加。

Then there are the issues involved in assigning identity to an ENTITY—irrelevant to a VALUE OBJECT. As pointed out in Chapter 5, an identifier can either be assigned automatically by the program or supplied from the outside, typically by the user. If a customer’s identity is to be tracked by the telephone number, then that telephone number must obviously be passed in as an argument to the FACTORY. When the program is assigning an identifier, the FACTORY is a good place to control it. Although the actual generation of a unique tracking ID is typically done by a database “sequence” or other infrastructure mechanism, the FACTORY knows what to ask for and where to put it.

> 我们来看一下为 ENTITY 分配标识时将涉及的问题（VALUE OBJECT 不会涉及这些问题）。正如第 5 章所指出的那样，既可以由程序自动分配一个标识符，也可以通过外部（通常是用户）提供一个标识符。如果客户的标识是通过电话号码跟踪的，那么该电话号码必须作为参数被显式地传递给 FACTORY。当由程序分配标识符时，FACTORY 是控制它的理想场所。尽管唯一跟踪 ID 实际上是由数据库“序列”或其他基础设施机制生成的，但 FACTORY 知道需要什么样的标识，以及将标识放到何处。

### 6.2.6 Reconstituting Stored Objects 重建已存储的对象

Up to this point, the FACTORY has played its part in the very beginning of an object’s life cycle. At some point, most objects get stored in databases or transmitted through a network, and few current database technologies retain the object character of their contents. Most transmission methods flatten an object into an even more limited presentation. Therefore, retrieval requires a potentially complex process of reassembling the parts into a live object.

> 到目前为止，FACTORY 只是发挥了它在对象生命周期开始时的作用。到了某一时刻，大部分对象都要存储在数据库中或通过网络传输，而在当前的数据库技术中，几乎没有哪种技术能够保持对象的内容特征。大多数传输方法都要将对象转换为平面数据才能传输，这使得对象只能以非常有限的形式出现。因此，检索操作潜在地需要一个复杂的过程将各个部分重新装配成一个可用的对象。

A FACTORY used for reconstitution is very similar to one used for creation, with two major differences.

> 用于重建对象的 FACTORY 与用于创建对象的 FACTORY 很类似，主要有以下两点不同。

1. An ENTITY FACTORY used for reconstitution does not assign a new tracking ID. To do so would lose the continuity with the object’s previous incarnation. So identifying attributes must be part of the input parameters in a FACTORY reconstituting a stored object.
2. A FACTORY reconstituting an object will handle violation of an invariant differently. During creation of a new object, a FACTORY should simply balk when an invariant isn’t met, but a more flexible response may be necessary in reconstitution. If an object already exists somewhere in the system (such as in the database), this fact cannot be ignored. Yet we also can’t ignore the rule violation. There has to be some strategy for repairing such inconsistencies, which can make reconstitution more challenging than the creation of new objects.

---

> 1. 用于重建对象的 ENTITY FACTORY 不分配新的跟踪 ID。如果重新分配 ID，将丢失与先前对象的连续性。因此，在重建对象的 FACTORY 中，标识属性必须是输入参数的一部分。
> 2. 当固定规则未被满足时，重建对象的 FACTORY 采用不同的方式进行处理。当创建新对象时，如果未满足固定规则，FACTORY 应该简单地拒绝创建对象，但在重建对象时则需要更灵活的响应。如果对象已经在系统的某个地方存在（如在数据库中），那么不能忽略这个事实。但是，同样也不能任凭规则被破坏。必须通过某种策略来修复这种不一致的情况，这使得重建对象比创建新对象更困难。

Figures 6.16 and 6.17 (on the next page) show two kinds of reconstitution. Object-mapping technologies may provide some or all of these services in the case of database reconstitution, which is convenient. Whenever there is exposed complexity in reconstituting an object from another medium, the FACTORY is a good option.

图 6-16 和图 6-17 显示了两种重建。当从数据库中重建对象时，对象映射技术就可以提供部分或全部所需服务，这是非常便利的。当从其他介质重建对象时，如果出现复杂情况，FACTORY 是个很好的选择。

<Figures figure="6-16">Reconstituting an ENTITY retrieved from a relational database</Figures>

<Figures figure="6-17">Reconstituting an ENTITY transmitted as XML</Figures>

To sum up, the access points for creation of instances must be identified, and their scope must be defined explicitly. They may simply be constructors, but often there is a need for a more abstract or elaborate instance creation mechanism. This need introduces new constructs into the design: FACTORIES. FACTORIES usually do not express any part of the model, yet they are a part of the domain design that helps keep the model-expressing objects sharp.

> 总之，必须把创建实例的访问点标识出来，并显式地定义它们的范围。它们可能只是构造函数，但通常需要有一种更抽象或更复杂的实例创建机制。为了满足这种需求，需要在设计中引入新的构造——FACTORY。FACTORY 通常不表示模型的任何部分，但它们是领域设计的一部分，能够使对象更明确地表示出模型。

A FACTORY encapsulates the life cycle transitions of creation and reconstitution. Another transition that exposes technical complexity that can swamp the domain design is the transition to and from storage. This transition is the responsibility of another domain design construct, the REPOSITORY.

> FACTORY 封装了对象创建和重建时的生命周期转换。还有一种转换大大增加了领域设计的技术复杂性，这是对象与存储之间的互相转换。这种转换由另一种领域设计构造来处理，它就是 REPOSITORY。

## 6.3 REPOSITORIES 模式：REPOSITORY

![](/figures/ch6/06inf03.jpg)

Associations allow us to find an object based on its relationship to another. But we must have a starting point for a traversal to an ENTITY or VALUE in the middle of its life cycle.

> 我们可以通过对象之间的关联来找到对象。但当它处于生命周期的中间时，必须要有一个起点，以便从这个起点遍历到一个 ENTITY 或 VALUE。

---

To do anything with an object, you have to hold a reference to it. How do you get that reference? One way is to create the object, as the creation operation will return a reference to the new object. A second way is to traverse an association. You start with an object you already know and ask it for an associated object. Any object-oriented program is going to do a lot of this, and these links give object models much of their expressive power. But you have to get that first object.

> 无论要用对象执行什么操作，都需要保持一个对它的引用。那么如何获得这个引用呢？一种方法是创建对象，因为创建操作将返回对新对象的引用。第二种方法是遍历关联。我们以一个已知对象作为起点，并向它请求一个关联的对象。这样的操作在任何面向对象的程序中都会大量用到，而且对象之间的这些链接使对象模型具有更强的表达能力。但我们必须首先获得作为起点的那个对象。

I actually encountered a project once in which the team was attempting, in an enthusiastic embrace of MODEL-DRIVEN DESIGN, to do all object access by creation or traversal! Their objects resided in an object database, and they reasoned that existing conceptual relationships would provide all necessary associations. They needed only to analyze them enough, making their entire domain model cohesive. This self-imposed limitation forced them to create just the kind of endless tangle that we have been trying to avert over the last few chapters, with careful implementation of ENTITIES and application of AGGREGATES. The team members didn’t stick with this strategy long, but they never replaced it with another coherent approach. They cobbled together ad hoc solutions and became less ambitious.

> 实际上，我曾经遇到过一个项目，团队成员对 MODEL-DRIVEN DESIGN 怀有极大的热情，因而试图通过创建对象或遍历对象的方法来访问所有对象。他们的对象存储在对象数据库中，而且他们推断出已有的概念关系将提供所有必要的关联。他们只需完成充分的分析工作，以便使整个领域满足内聚的要求。这种自己强加的限制导致他们创建出的模型错综复杂，而前几章我们一直试图通过仔细地实现 ENTITY 和应用 AGGREGATE 来避免这种复杂性。这种策略并没有坚持多长时间，但团队成员也一直没有用一种更有条理的方法来取代它。他们临时拼凑了一些解决方案，并放弃了最初的宏伟抱负。

Few would even think of this approach, much less be tempted by it, because they store most of their objects in relational databases. This storage technology makes it natural to use the third way of getting a reference: Execute a query to find the object in a database based on its attributes, or find the constituents of an object and then reconstitute it.

> 想到这种方法的人并不多，尝试它的人就更少了，因为人们将大部分对象存储在关系数据库中。这种存储技术使人们自然而然地使用第三种获取引用的方式——基于对象的属性，执行查询来找到对象；或者是找到对象的组成部分，然后重建它。

A database search is globally accessible and makes it possible to go directly to any object. There is no need for all objects to be interconnected, which allows us to keep the web of objects manageable. Whether to provide a traversal or depend on a search becomes a design decision, trading off the decoupling of the search against the cohesiveness of the association. Should the Customer object hold a collection of all the Orders placed? Or should the Orders be found in the database, with a search on the Customer ID field? The right combination of search and association makes the design comprehensible.

> 数据库搜索是全局可访问的，它使我们可以直接访问任何对象。由此，所有对象不需要相互联接起来，整个对象关系网就能够保持在可控的范围内。是提供遍历还是依靠搜索，这成为一个设计决策，需要在搜索的解耦与关联的内聚之间做出权衡。Customer 对象应该保持该客户所有已订的 Order 吗？应该通过 Customer ID 字段在数据库中查找 Order 吗？恰当地结合搜索与关联将会得到易于理解的设计。

Unfortunately, developers don’t usually get to think much about such design subtleties, because they are swimming in the sea of mechanisms needed to pull off the trick of storing an object and bringing it back—and eventually removing it from storage.

> 遗憾的是，开发人员一般不会过多地考虑这种精细的设计，因为他们满脑子都是需要用到的机制，以便很有技巧地利用它们来实现对象的存储、取回和最终删除。

Now from a technical point of view, retrieval of a stored object is really a subset of creation, because the data from the database is used to assemble new objects. Indeed, the code that usually has to be written makes it hard to forget this reality. But conceptually, this is the middle of the life cycle of an ENTITY. A Customer object does not represent a new customer just because we stored it in a database and retrieved it. To keep this distinction in mind, I refer to the creation of an instance from stored data as reconstitution.

> 现在，从技术的观点来看，检索已存储对象实际上属于创建对象的范畴，因为从数据库中检索出来的数据要被用来组装新的对象。实际上，由于需要经常编写这样的代码，我们对此形成了根深蒂固的观念。但从概念上讲，对象检索发生在 ENTITY 生命周期的中间。不能只是因为我们将 Customer 对象保存在数据库中，而后把它检索出来，这个 Customer 就代表了一个新客户。为了记住这个区别，我把使用已存储的数据创建实例的过程称为重建。

The goal of domain-driven design is to create better software by focusing on a model of the domain rather than the technology. By the time a developer has constructed an SQL query, passed it to a query service in the infrastructure layer, obtained a result set of table rows, pulled the necessary information out, and passed it to a constructor or FACTORY, the model focus is gone. It becomes natural to think of the objects as containers for the data that the queries provide, and the whole design shifts toward a data-processing style. The details of the technology vary, but the problem remains that the client is dealing with technology, rather than model concepts. Infrastructure such as METADATA MAPPING LAYERS (Fowler 2003) help a great deal, by making easier the conversion of the query result into objects, but the developer is still thinking about technical mechanisms, not the domain. Worse, as client code uses the database directly, developers are tempted to bypass model features such as AGGREGATES, or even object encapsulation, instead directly taking and manipulating the data they need. More and more domain rules become embedded in query code or simply lost. Object databases do eliminate the conversion problem, but search mechanisms are usually still mechanistic, and developers are still tempted to grab whatever objects they want.

> 领域驱动设计的目标是通过关注领域模型（而不是技术）来创建更好的软件。假设开发人员构造了一个 SQL 查询，并将它传递给基础设施层中的某个查询服务，然后再根据得到的表行数据的结果集提取出所需信息，最后将这些信息传递给构造函数或 FACTORY。开发人员执行这一连串操作的时候，早已不再把模型当作重点了。我们很自然地会把对象看作容器来放臵查询出来的数据，这样整个设计就转向了数据处理风格。虽然具体的技术细节有所不同，但问题仍然存在——客户处理的是技术，而不是模型概念。诸如 METADATA MAPPING LAYER[Fowler 2002]这样的基础设施可以提供很大帮助，利用它很容易将查询结果转换为对象，但开发人员考虑的仍然是技术机制，而不是领域。更糟的是，当客户代码直接使用数据库时，开发人员会试图绕过模型的功能（如 AGGREGATE，甚至是对象封装），而直接获取和操作他们所需的数据。这将导致越来越多的领域规则被嵌入到查询代码中，或者干脆丢失了。虽然对象数据库消除了转换问题，但搜索机制还是很机械的，开发人员仍倾向于要什么就去拿什么。

A client needs a practical means of acquiring references to preexisting domain objects. If the infrastructure makes it easy to do so, the developers of the client may add more traversable associations, muddling the model. On the other hand, they may use queries to pull the exact data they need from the database, or to pull a few specific objects rather than navigating from AGGREGATE roots. Domain logic moves into queries and client code, and the ENTITIES and VALUE OBJECTS become mere data containers. The sheer technical complexity of applying most database access infrastructure quickly swamps the client code, which leads developers to dumb down the domain layer, which makes the model irrelevant.

> 客户需要一种有效的方式来获取对已存在的领域对象的引用。如果基础设施提供了这方面的便利，那么开发人员可能会增加很多可遍历的关联，这会使模型变得非常混乱。另一方面，开发人员可能使用查询从数据库中提取他们所需的数据，或是直接提取具体的对象，而不是通过 AGGREGATE 的根来得到这些对象。这样就导致领域逻辑进入查询和客户代码中，而 ENTITY 和 VALUE OBJECT 则变成单纯的数据容器。采用大多数处理数据库访问的技术复杂性很快就会使客户代码变得混乱，这将导致开发人员简化领域层，最终使模型变得无关紧要。

Drawing on the design principles discussed so far, we can reduce the scope of the object access problem somewhat, assuming that we find a method of access that keeps the model focus sharp enough to employ those principles. For starters, we need not concern ourselves with transient objects. Transients (typically VALUE OBJECTS) live brief lives, used in the client operation that created them and then discarded. We also need no query access for persistent objects that are more convenient to find by traversal. For example, the address of a person could be requested from the Person object. And most important, any object internal to an AGGREGATE is prohibited from access except by traversal from the root.

> 根据到目前为止所讨论的设计原则，如果我们找到一种访问方法，它能够明确地将模型作为焦点，从而应用这些原则，那么我们就可以在某种程度上缩小对象访问问题的范围，。初学者可以不必关心临时对象。临时对象（通常是 VALUE OBJECT）只存在很短的时间，在客户操作中用到它们时才创建它们，用完就删除了。我们也不需要对那些很容易通过遍历来找到的持久对象进行查询访问。例如，地址可以通过 Person 对象获取。而且最重要的是，除了通过根来遍历查找对象这种方法以外，禁止用其他方法对 AGGREGATE 内部的任何对象进行访问。

Persistent VALUE OBJECTS are usually found by traversal from some ENTITY that acts as the root of the AGGREGATE that encapsulates them. In fact, a global search access to a VALUE is often meaningless, because finding a VALUE by its properties would be equivalent to creating a new instance with those properties. There are exceptions, though. For example, when I am planning travel online, I sometimes save a few prospective itineraries and return later to select one to book. Those itineraries are VALUES (if there were two made up of the same flights, I would not care which was which), but they have been associated with my user name and retrieved for me intact. Another case would be an “enumeration,” when a type has a strictly limited, predetermined set of possible values. Global access to VALUE OBJECTS is much less common than for ENTITIES, though, and if you find you need to search the database for a preexisting VALUE, it is worth considering the possibility that you’ve really got an ENTITY whose identity you haven’t recognized.

> 持久化的 VALUE OBJECT 一般可以通过遍历某个 ENTITY 来找到，在这里 ENTITY 就是把对象封装在一起的 AGGREGATE 的根。事实上，对 VALUE 的全局搜索访问常常是没有意义的，因为通过属性找到 VALUE OBJECT 相当于用这些属性创建一个新实例。但也有例外情况。例如，当我在线规划旅行线路时，有时会先保存几个中意的行程，过后再回头从中选择一个来预订。这些行程就是 VALUE（如果两个行程由相同的航班构成，那么我不会关心哪个是哪个），但它们已经与我的用户名关联到一起了，而且可以原封不动地将它们检索出来。另一个例子是“枚举”，在枚举中一个类型有一组严格限定的、预定义的可能值。但是，对 VALUE OBJECT 的全局访问比对 ENTITY 的全局访问更少见，如果确实需要在数据库中搜索一个已存在的 VALUE，那么值得考虑一下，搜索结果可能实际上是一个 ENTITY，只是尚未识别它的标识。

From this discussion, it is clear that most objects should not be accessed by a global search. It would be nice for the design to communicate those that do.

> 从上面的讨论显然可以看出，大多数对象都不应该通过全局搜索来访问。如果很容易就能从设计中看出那些确实需要全局搜索访问的对象，那该有多好！

Now the problem can be restated more precisely.

> 现在可以更精确地将问题重新表述如下：

A subset of persistent objects must be globally accessible through a search based on object attributes. Such access is needed for the roots of AGGREGATES that are not convenient to reach by traversal. They are usually ENTITIES, sometimes VALUE OBJECTS with complex internal structure, and sometimes enumerated VALUES. Providing access to other objects muddies important distinctions. Free database queries can actually breach the encapsulation of domain objects and AGGREGATES. Exposure of technical infrastructure and database access mechanisms complicates the client and obscures the MODEL-DRIVEN DESIGN.

> 在所有持久化对象中，有一小部分必须通过基于对象属性的搜索来全局访问。当很难通过遍历方式来访问某些 AGGREGATE 根的时候，就需要使用这种访问方式。它们通常是 ENTITY，有时是具有复杂内部结构的 VALUE OBJECT，还可能是枚举 VALUE。而其他对象则不宜使用这种访问方式，因为这会混淆它们之间的重要区别。随意的数据库查询会破坏领域对象的封装和 AGGREGATE。技术基础设施和数据库访问机制的暴露会增加客户的复杂度，并妨碍模型驱动的设计。

There is a raft of techniques for dealing with the technical challenges of database access. Examples include encapsulating SQL into QUERY OBJECTS or translating between objects and tables with METADATA MAPPING LAYERS (Fowler 2003). FACTORIES can help reconstitute stored objects (as discussed later in this chapter). These and many other techniques help keep a lid on complexity.

> 有大量的技术可以用来解决数据库访问的技术难题，例如，将 SQL 封装到 QUERY OBJECT 中，或利用 METADATA MAPPING LAYER 进行对象和表之间的转换[Fowler 2002]。FACTORY 可以帮助重建那些已存储的对象（本章后面将会讨论）。这些技术和很多其他技术有助于控制数据库访问的复杂度。

But even so, take note of what has been lost. We are no longer thinking about concepts in our domain model. Our code will not be communicating about the business; it will be manipulating the technology of data retrieval. The REPOSITORY pattern is a simple conceptual framework to encapsulate those solutions and bring back our model focus.

> 有得必有失，我们应该注意失去了什么。我们已经不再考虑领域模型中的概念。代码也不再表达业务，而是对数据库检索技术进行操纵。REPOSITORY 是一个简单的概念框架，它可用来封装这些解决方案，并将我们的注意力重新拉回到模型上。

A REPOSITORY represents all objects of a certain type as a conceptual set (usually emulated). It acts like a collection, except with more elaborate querying capability. Objects of the appropriate type are added and removed, and the machinery behind the REPOSITORY inserts them or deletes them from the database. This definition gathers a cohesive set of responsibilities for providing access to the roots of AGGREGATES from early life cycle through the end.

> REPOSITORY 将某种类型的所有对象表示为一个概念集合（通常是模拟的）。它的行为类似于集合（collection），只是具有更复杂的查询功能。在添加或删除相应类型的对象时，REPOSITORY 的后台机制负责将对象添加到数据库中，或从数据库中删除对象。这个定义将一组紧密相关的职责集中在一起，这些职责提供了对 AGGREGATE 根的整个生命周期的全程访问。

Clients request objects from the REPOSITORY using query methods that select objects based on criteria specified by the client, typically the value of certain attributes. The REPOSITORY retrieves the requested object, encapsulating the machinery of database queries and metadata mapping. REPOSITORIES can implement a variety of queries that select objects based on whatever criteria the client requires. They can also return summary information, such as a count of how many instances meet some criteria. They can even return summary calculations, such as the total across all matching objects of some numerical attribute.

> 客户使用查询方法向 REPOSITORY 请求对象，这些查询方法根据客户所指定的条件（通常是特定属性的值）来挑选对象。REPOSITORY 检索被请求的对象，并封装数据库查询和元数据映射机制。REPOSITORY 可以根据客户所要求的各种条件来挑选对象。它们也可以返回汇总信息，如有多少个实例满足查询条件。REPOSITORY 甚至能返回汇总计算，如所有匹配对象的某个数值属性的总和，如图 6-18 所示。

<Figures figure="6-18">A REPOSITORY doing a search for a client</Figures>

A REPOSITORY lifts a huge burden from the client, which can now talk to a simple, intention-revealing interface, and ask for what it needs in terms of the model. To support all this requires a lot of complex technical infrastructure, but the interface is simple and conceptually connected to the domain model.

> REPOSITORY 解除了客户的巨大负担，使客户只需与一个简单的、易于理解的接口进行对话，并根据模型向这个接口提出它的请求。要实现所有这些功能需要大量复杂的技术基础设施，但接口很简单，而且在概念层次上与领域模型紧密联系在一起。

Therefore:

> 因此：

For each type of object that needs global access, create an object that can provide the illusion of an in-memory collection of all objects of that type. Set up access through a well-known global interface. Provide methods to add and remove objects, which will encapsulate the actual insertion or removal of data in the data store. Provide methods that select objects based on some criteria and return fully instantiated objects or collections of objects whose attribute values meet the criteria, thereby encapsulating the actual storage and query technology. Provide REPOSITORIES only for AGGREGATE roots that actually need direct access. Keep the client focused on the model, delegating all object storage and access to the REPOSITORIES.

> 为每种需要全局访问的对象类型创建一个对象，这个对象相当于该类型的所有对象在内存中的一个集合的“替身”。通过一个众所周知的全局接口来提供访问。提供添加和删除对象的方法，用这些方法来封装在数据存储中实际插入或删除数据的操作。提供根据具体条件来挑选对象的方法，并返回属性值满足查询条件的对象或对象集合（所返回的对象是完全实例化的），从而将实际的存储和查询技术封装起来。只为那些确实需要直接访问的 AGGREGATE 根提供 REPOSITORY。让客户始终聚焦于模型，而将所有对象的存储和访问操作交给 REPOSITORY 来完成。

---

REPOSITORIES have many advantages, including the following:

> REPOSITORY 有很多优点，包括：

- They present clients with a simple model for obtaining persistent objects and managing their life cycle.
- They decouple application and domain design from persistence technology, multiple database strategies, or even multiple data sources.
- They communicate design decisions about object access.
- They allow easy substitution of a dummy implementation, for use in testing (typically using an in-memory collection).

---

> - 它们为客户提供了一个简单的模型，可用来获取持久化对象并管理它们的生命周期；
> - 它们使应用程序和领域设计与持久化技术（多种数据库策略甚至是多个数据源）解耦；
> - 它们体现了有关对象访问的设计决策；
> - 可以很容易将它们替换为“哑实现”（dummy implementation），以便在测试中使用（通常使用内存中的集合）。

### 6.3.1 Querying a REPOSITORY REPOSITORY 的查询

All repositories provide methods that allow a client to request objects matching some criteria, but there is a range of options of how to design this interface.

> 所有 REPOSITORY 都为客户提供了根据某种条件来查询对象的方法，但如何设计这个接口却有很多选择。

The easiest REPOSITORY to build has hard-coded queries with specific parameters. These queries can be various: retrieving an ENTITY by its identity (provided by almost all REPOSITORIES); requesting a collection of objects with a particular attribute value or a complex combination of parameters; selecting objects based on value ranges (such as date ranges); and even performing some calculations that fall within the general responsibility of a REPOSITORY (especially drawing on operations supported by the underlying database).

> 最容易构建的 REPOSITORY 用硬编码的方式来实现一些具有特定参数的查询。这些查询可以形式各异，例如，通过标识来检索 ENTITY（几乎所有 REPOSITORY 都提供了这种查询）、通过某个特定属性值或复杂的参数组合来请求一个对象集合、根据值域（如日期范围）来选择对象，甚至可以执行某些属于 REPOSITORY 一般职责范围内的计算（特别是利用那些底层数据库所支持的操作）。如图 6-19 所示。

Although most queries return an object or a collection of objects, it also fits within the concept to return some types of summary calculations, such as an object count, or a sum of a numerical attribute that was intended by the model to be tallied.

> 尽管大多数查询都返回一个对象或对象集合，但返回某些类型的汇总计算也符合 REPOSITORY 的概念，如对象数目，或模型需要对某个数值属性进行求和统计。

<Figures figure="6-19">Hard-coded queries in a simple REPOSITORY</Figures>

Hard-coded queries can be built on top of any infrastructure and without a lot of investment, because they do just what some client would have had to do anyway.

> 在任何基础设施上，都可以构建硬编码式的查询，也不需要很大的投入，因为即使它们不做这些事，有些客户也必须要做。

On projects with a lot of querying, a REPOSITORY framework can be built that allows more flexible queries. This calls for a staff familiar with the necessary technology and is greatly aided by a supportive infrastructure.

> 在一些需要执行大量查询的项目上，可以构建一个支持更灵活查询的 REPOSITORY 框架。如图 6-20 所示。这要求开发人员熟悉必要的技术，而且一个支持性的基础设施会提供巨大的帮助。

One particularly apt approach to generalizing REPOSITORIES through a framework is to use SPECIFICATION-based queries. A SPECIFICATION allows a client to describe (that is, specify) what it wants without concern for how it will be obtained. In the process, an object that can actually carry out the selection is created. This pattern will be discussed in depth in Chapter 9.

> 基于 SPECIFICATION（规格）的查询是将 REPOSITORY 通用化的好办法。客户可以使用规格来描述（也就是指定）它需要什么，而不必关心如何获得结果。在这个过程中，可以创建一个对象来实际执行筛选操作。第 9 章将深入讨论这种模式。

<Figures figure="6-20">A flexible, declarative SPECIFICATION of search criteria in a sophisticated REPOSITORY</Figures>

The SPECIFICATION-based query is elegant and flexible. Depending on the infrastructure available, it may be a modest framework or it may be prohibitively difficult. Rob Mee and Edward Hieatt discuss more of the technical issues involved in designing such REPOSITORIES in Fowler 2003.

> 基于 SPECIFICATION 的查询是一种优雅且灵活的查询方法。根据所用的基础设施的不同，它可能易于实现，也可能极为复杂。Rob Mee 和 Edward Hieatt 在[Fowler 2002]一书中探讨了设计这样的 REPOSITORY 时所涉及的更多技术问题。

Even a REPOSITORY design with flexible queries should allow for the addition of specialized hard-coded queries. They might be convenience methods that encapsulate an often-used query or a query that doesn’t return the objects themselves, such as a mathematical summary of selected objects. Frameworks that don’t allow for such contingencies tend to distort the domain design or get bypassed by developers.

> 即使一个 REPOSITORY 的设计采取了灵活的查询方式，也应该允许添加专门的硬编码查询。这些查询作为便捷的方法，可以封装常用查询或不返回对象（如返回的是选中对象的汇总计算）的查询。不支持这些特殊查询方式的框架有可能会扭曲领域设计，或是干脆被开发人员弃之不用。

### 6.3.2 Client Code Ignores REPOSITORY Implementation; Developers Do Not 客户代码可以忽略 REPOSITORY 的实现，但开发人员不能忽略

Encapsulation of the persistence technology allows the client to be very simple, completely decoupled from the implementation of the REPOSITORY. But as is often the case with encapsulation, the developer must understand what is happening under the hood. The performance implications can be extreme when REPOSITORIES are used in different ways or work in different ways.

> 持久化技术的封装可以使得客户变得十分简单，并且使客户与 REPOSITORY 的实现之间完全解耦。但像一般的封装一样，开发人员必须知道在封装背后都发生了什么事情。在使用 REPOSITORY 时，不同的使用方式或工作方式可能会对性能产生极大的影响。

Kyle Brown told me the story of getting called in on a manufacturing application based on WebSphere that was being rolled out to production. The system was mysteriously running out of memory after a few hours of use. Kyle browsed through the code and found the reason: At one point, they were summarizing some information about every item in the plant. The developers had done this using a query called “all objects,” which instantiated each of the objects and then selected the bits they needed. This code had the effect of bringing the entire database into memory at once! The problem hadn’t shown up in testing because of the small amount of test data.

> Kyle Brown 曾告诉过我他的一段经历，有一次他被请去解决一个基于 WebSphere 的制造业应用程序的问题，当时这个程序正向生产环境部署。系统在运行几小时后会莫名其妙地耗尽内存。Kyle 在检查代码后发现了原因：在某一时刻，系统需要将工厂中每件产品的信息汇总到一起。开发人员使用了一个名为 all objects（所有对象）的查询来进行汇总，这个操作对每个对象进行实例化，然后选择他们所需的数据。这段代码的结果是一次性将整个数据库装入内存中！这个问题在测试中并未发现，原因是测试数据较少。

This is an obvious no-no, but much more subtle oversights can present equally serious problems. Developers need to understand the implications of using encapsulated behavior. That does not have to mean detailed familiarity with the implementation. Well-designed components can be characterized. (This is one of the main points of Chapter 10, “Supple Design.”)

> 这是一个明显的禁忌，而一些更不容易注意到的疏忽可能会产生同样严重的问题。开发人员需要理解使用封装行为的隐含问题，但这并不意味着要熟悉实现的每个细节。设计良好的组件是有显著特征的（这是第 10 章的重点之一）。

As was discussed in Chapter 5, the underlying technology may constrain your modeling choices. For example, a relational database can place a practical limit on deep compositional object structures. In just the same way, there must be feedback to developers in both directions between the use of the REPOSITORY and the implementation of its queries.

> 正如第 5 章所讨论的那样，底层技术可能会限制我们的建模选择。例如，关系数据库可能对复合对象结构的深度有实际的限制。同样，开发人员要获得 REPOSITORY 的使用及其查询实现之间的双向反馈。

### 6.3.3 Implementing a REPOSITORY REPOSITORY 的实现

Implementation will vary greatly, depending on the technology being used for persistence and the infrastructure you have. The ideal is to hide all the inner workings from the client (although not from the developer of the client), so that client code will be the same whether the data is stored in an object database, stored in a relational database, or simply held in memory. The REPOSITORY will delegate to the appropriate infrastructure services to get the job done. Encapsulating the mechanisms of storage, retrieval, and query is the most basic feature of a REPOSITORY implementation.

> 根据所使用的持久化技术和基础设施不同，REPOSITORY 的实现也将有很大的变化。理想的实现是向客户隐藏所有内部工作细节（尽管不向客户的开发人员隐藏这些细节），这样不管数据是存储在对象数据库中，还是存储在关系数据库中，或是简单地保持在内存中，客户代码都相同。REPOSITORY 将会委托相应的基础设施服务来完成工作。将存储、检索和查询机制封装起来是 REPOSITORY 实现的最基本的特性，如图 6-21 所示。

<Figures figure="6-21">The REPOSITORY encapsulates the underlying data store.</Figures>

The REPOSITORY concept is adaptable to many situations. The possibilities of implementation are so diverse that I can only list some concerns to keep in mind.

> REPOSITORY 概念在很多情况下都适用。可能的实现方法有很多，这里只能列出如下一些需要谨记的注意事项。

- Abstract the type. A REPOSITORY “contains” all instances of a specific type, but this does not mean that you need one REPOSITORY for each class. The type could be an abstract superclass of a hierarchy (for example, a TradeOrder could be a BuyOrder or a Sell-Order). The type could be an interface whose implementers are not even hierarchically related. Or it could be a specific concrete class. Keep in mind that you may well face constraints imposed by the lack of such polymorphism in your database technology.
- Take advantage of the decoupling from the client. You have more freedom to change the implementation of a REPOSITORY than you would if the client were calling the mechanisms directly. You can take advantage of this to optimize for performance, by varying the query technique or by caching objects in memory, freely switching persistence strategies at any time. You can facilitate testing of the client code and the domain objects by providing an easily manipulated, dummy in-memory strategy.
- Leave transaction control to the client. Although the REPOSITORY will insert into and delete from the database, it will ordinarily not commit anything. It is tempting to commit after saving, for example, but the client presumably has the context to correctly initiate and commit units of work. Transaction management will be simpler if the REPOSITORY keeps its hands off.

---

> - 对类型进行抽象。REPOSITORY“含有”特定类型的所有实例，但这并不意味着每个类都需要有一个 REPOSITORY。类型可以是一个层次结构中的抽象超类（例如，TradeOrder 可以是 BuyOrder 或 SellOrder）。类型可以是一个接口——接口的实现者并没有层次结构上的关联，也可以是一个具体类。记住，由于数据库技术缺乏这样的多态性质，因此我们将面临很多约束。
> - 充分利用与客户解耦的优点。我们可以很容易地更改 REPOSITORY 的实现，但如果客户直接调用底层机制，我们就很难修改其实现。也可以利用解耦来优化性能，因为这样就可以使用不同的查询技术，或在内存中缓存对象，可以随时自由地切换持久化策略。通过提供一个易于操纵的、内存中的（in-memory）哑实现，还能够方便客户代码和领域对象的测试。
> - 将事务的控制权留给客户。尽管 REPOSITORY 会执行数据库的插入和删除操作，但它通常不会提交事务。例如，保存数据后紧接着就提交似乎是很自然的事情，但想必只有客户才有上下文，从而能够正确地初始化和提交工作单元。如果 REPOSITORY 不插手事务控制，那么事务管理就会简单得多。

Typically teams add a framework to the infrastructure layer to support the implementation of REPOSITORIES. In addition to the collaboration with the lower level infrastructure components, the REPOSITORY superclass might implement some basic queries, especially when a flexible query is being implemented. Unfortunately, with a type system such as Java’s, this approach would force you to type returned objects as “Object,” leaving the client to cast them to the REPOSITORY’S contained type. But of course, this will have to be done with queries that return collections anyway in Java.

> 通常，项目团队会在基础设施层中添加框架，用来支持 REPOSITORY 的实现。REPOSITORY 超类除了与较低层的基础设施组件进行协作以外，还可以实现一些基本查询，特别是要实现的灵活查询时。遗憾的是，对于类似 Java 这样的类型系统，这种方法会使返回的对象只能是 Object 类型，而让客户将它们转换为 REPOSITORY 含有的类型。当然，如果在 Java 中查询所返回的对象是集合时，客户不管怎样都要执行这样的转换。

Some additional guidance on implementing REPOSITORIES and some of their supporting technical patterns such as QUERY OBJECT can be found in Fowler (2003).

> 有关实现 REPOSITORY 的更多指导和一些支持性技术模式（如 QUERY OBJECT）可以在[Fowler2002]一书中找到。

### 6.3.4 Working Within Your Frameworks 在框架内工作

Before implementing something like a REPOSITORY, you need to think carefully about the infrastructure you are committed to, especially any architectural frameworks. You may find that the framework provides services you can use to easily create a REPOSITORY, or you may find that the framework fights you all the way. You may discover that the architectural framework has already defined an equivalent pattern of getting persistent objects. Or you may discover that it has defined a pattern that is not like a REPOSITORY at all.

> 在实现 REPOSITORY 这样的构造之前，需要认真思考所使用的基础设施，特别是架构框架。这些框架可能提供了一些可用来轻松创建 REPOSITORY 的服务，但也可能会妨碍创建 REPOSITORY 的工作。我们可能会发现架构框架已经定义了一种用来获取持久化对象的等效模式，也有可能定义了一种与 REPOSITORY 完全不同的模式。

For example, your project might be committed to J2EE. Looking for conceptual affinities between the framework and the patterns of MODEL-DRIVEN DESIGN (and keeping in mind that an entity bean is not the same thing as an ENTITY), you may have chosen to use entity beans to correspond to AGGREGATE roots. The construct within the architectural framework of J2EE that is responsible for providing access to these objects is the “EJB Home.” Trying to dress up the EJB Home to look like a REPOSITORY could lead to other problems.

> 例如，你的项目可能会使用 J2EE。看看这个框架与 MODEL-DRIVEN DESIGN 的模式之间有哪些概念上近似的地方（记住，实体 bean 与 ENTITY 不是一回事），你可能会把实体 bean 和 AGGREGATE 根当作一对类似的概念。在 J2EE 框架中，负责对这些对象进行访问的构造是 EJBHome。但如果把 EJB Home 装饰成 REPOSITORY 的样子可能会导致其他问题。

In general, don’t fight your frameworks. Seek ways to keep the fundamentals of domain-driven design and let go of the specifics when the framework is antagonistic. Look for affinities between the concepts of domain-driven design and the concepts in the framework. This is assuming that you have no choice but to use the framework. Many J2EE projects don’t use entity beans at all. If you have the freedom, choose frameworks, or parts of frameworks, that are harmonious with the style of design you want to use.

> 一般来讲，在使用框架时要顺其自然。当框架无法切合时，要想办法在大方向上保持领域驱动设计的基本原理，而一些不符的细节则不必过分苛求。寻求领域驱动设计的概念与框架中的概念之间的相似性。这里的假设是除了使用指定框架之外没有别的选择。很多 J2EE 项目根本不使用实体 bean。如果可以自由选择，那么应该选择与你所使用的设计风格相协调的框架或框架中的一些部分。

### 6.3.5 The Relationship with FACTORIES REPOSITORY 与 FACTORY 的关系

A FACTORY handles the beginning of an object’s life; a REPOSITORY helps manage the middle and the end. When objects are being held in memory, or stored in an object database, this is straightforward. But typically there is at least some object storage in relational databases, files, or other, non-object-oriented systems. In such cases, the retrieved data must be reconstituted into object form.

> FACTORY 负责处理对象生命周期的开始，而 REPOSITORY 帮助管理生命周期的中间和结束。当对象驻留在内存中或存储在对象数据库中时，这是很好理解的。但通常至少有一部分对象存储在关系数据库、文件或其他非面向对象的系统中。在这些情况下，检索出来的数据必须被重建为对象形式。

Because the REPOSITORY is, in this case, creating objects based on data, many people consider the REPOSITORY to be a FACTORY—indeed it is, from a technical point of view. But it is more useful to keep the model in the forefront, and as mentioned before, the reconstitution of a stored object is not the creation of a new conceptual object. In this domain-driven view of the design, FACTORIES and REPOSITORIES have distinct responsibilities. The FACTORY makes new objects; the REPOSITORY finds old objects. The client of a REPOSITORY should be given the illusion that the objects are in memory. The object may have to be reconstituted (yes, a new instance may be created), but it is the same conceptual object, still in the middle of its life cycle.

> 由于在这种情况下 REPOSITORY 基于数据来创建对象，因此很多人认为 REPOSITORY 就是 FACTORY，而从技术角度来看的确如此。但我们最好还是从模型的角度来看待这一问题，前面讲过，重建一个已存储的对象并不是创建一个新的概念对象。从领域驱动设计的角度来看，FACTORY 和 REPOSITORY 具有完全不同的职责。FACTORY 负责制造新对象，而 REPOSITORY 负责查找已有对象。REPOSITORY 应该让客户感觉到那些对象就好像驻留在内存中一样。对象可能必须被重建（的确，可能会创建一个新实例），但它是同一个概念对象，仍旧处于生命周期的中间。

These two views can be reconciled by making the REPOSITORY delegate object creation to a FACTORY, which (in theory, though seldom in practice) could also be used to create objects from scratch.

> REPOSITORY 也可以委托 FACTORY 来创建一个对象，这种方法（虽然实际很少这样做，但在理论上是可行的）可用于从头开始创建对象，此时就没有必要区分这两种看问题的角度了，如图 6-22 所示。

<Figures figure="6-22">A REPOSITORY uses a FACTORY to reconstitute a preexisting object.</Figures>

This clear separation also helps by unloading all responsibility for persistence from the FACTORIES. A FACTORY’S job is to instantiate a potentially complex object from data. If the product is a new object, the client will know this and can add it to the REPOSITORY, which will encapsulate the storage of the object in the database.

> 这种职责上的明确区分还有助于 FACTORY 摆脱所有持久化职责。FACTORY 的工作是用数据来实例化一个可能很复杂的对象。如果产品是一个新对象，那么客户将知道在创建完成之后应该把它添加到 REPOSITORY 中，由 REPOSITORY 来封装对象在数据库中的存储，如图 6-23 所示。

<Figures figure="6-23">A client uses a REPOSITORY to store a new object.</Figures>

One other case that drives people to combine FACTORY and REPOSITORY is the desire for “find or create” functionality, in which a client can describe an object it wants and, if no such object is found, will be given a newly created one. This function should be avoided. It is a minor convenience at best. A lot of cases in which it seems useful go away when ENTITIES and VALUE OBJECTS are distinguished. A client that wants a VALUE OBJECT can go straight to a FACTORY and ask for a new one. Usually, the distinction between a new object and an existing object is important in the domain, and a framework that transparently combines them will actually muddle the situation.

> 另一种情况促使人们将 FACTORY 和 REPOSITORY 结合起来使用，这就是想要实现一种“查找或创建”功能，即客户描述它所需的对象，如果找不到这样的对象，则为客户新创建一个。我们最好不要追求这种功能，它不会带来多少方便。当将 ENTITY 和 VALUE OBJECT 区分开时，很多看上去有用的功能就不复存在了。需要 VALUE OBJECT 的客户可以直接请求 FACTORY 来创建一个。通常，在领域中将新对象和原有对象区分开是很重要的，而将它们组合在一起的框架实际上只会使局面变得混乱。

## 6.4 DESIGNING OBJECTS FOR RELATIONAL DATABASES 为关系数据库设计对象

The most common nonobject component of primarily object-oriented software systems is the relational database. This reality presents the usual problems of a mixture of paradigms (see Chapter 5). But the database is more intimately related to the object model than are most other components. The database is not just interacting with the objects; it is storing the persistent form of the data that makes up the objects themselves. A good deal has been written about the technical challenges of mapping objects to relational tables and effectively storing and retrieving them. A recent discussion can be found in Fowler 2003. There are reasonably refined tools for creating and managing mappings between the two. Apart from the technical concerns, this mismatch can have a significant impact on the object model.

> 在以面向对象技术为主的软件系统中，最常用的非对象组件就是关系数据库。这种现状产生了混合使用范式的常见问题（参见第 5 章）。但与大部分其他组件相比，数据库与对象模型的关系要紧密得多。数据库不仅仅与对象进行交互，而且它还把构成对象的数据存储为持久化形式。已经有大量的文献对于如何将对象映射到关系表以及如何有效存储和检索它们这样的技术挑战进行了讨论。最近的一篇讨论可参见[Fowler 2002]一书。有一些相当完善的工具可用来创建和管理它们之间的映射。除了技术上的难点以外，这种不匹配可能对对象模型产生很大的影响。

There are three common cases:

> 有 3 种常见情况：

1. The database is primarily a repository for the objects.
2. The database was designed for another system.
3. The database is designed for this system but serves in roles other than object store.

---

> 1. 数据库是对象的主要存储库；
> 2. 数据库是为另一个系统设计的；
> 3. 数据库是为这个系统设计的，但它的任务不是用于存储对象。

When the database schema is being created specifically as a store for the objects, it is worth accepting some model limitations in order to keep the mapping very simple. Without other demands on schema design, the database can be structured to make aggregate integrity safer and more efficient as updates are made. Technically, the relational table design does not have to reflect the domain model. Mapping tools are sophisticated enough to bridge significant differences. The trouble is, multiple overlapping models are just too complicated. Many of the same arguments presented for MODEL-DRIVEN DESIGN—avoiding separate analysis and design models—apply to this mismatch. This does entail some sacrifice in the richness of the object model, and sometimes compromises have to be made in the database design (such as selective denormalization), but to do otherwise is to risk losing the tight coupling of model and implementation. This approach doesn’t require a simplistic one-object/one-table mapping. Depending on the power of the mapping tool, some aggregation or composition of objects may be possible. But it is crucial that the mappings be transparent, easily understandable by inspecting the code or reading entries in the mapping tool.

> 如果数据库模式（database schema）是专门为对象存储而设计的，那么接受模型的一些限制是值得的，这样可以让映射变得简单一点。如果在数据库模式设计上没有其他的要求，那么可以精心设计数据库结构，以便使得在更新数据时能更安全地保证聚合的完整性，并使数据更新变得更加高效。从技术上来看，关系表的设计不必反映出领域模型。映射工具已经非常完善了，足以消除二者之间的巨大差别。问题在于多个重叠的模型过于复杂了。MODEL-DRIVEN DESIGN 的很多关于避免将分析和设计模型分开的观点，也同样适用于这种不匹配问题。这确实会牺牲一些对象模型的丰富性，而且有时必须在数据库设计中做出一些折中（如有些地方不能规范化）。但如果不做这些牺牲就会冒另一种风险，那就是模型与实现之间失去了紧密的耦合。这种方法并不要必须使用一种简单的、一个对象/一个表的映射。依靠映射工具的功能，可以实现一些聚合或对象的组合。但至关重要的是：映射要保持透明，并易于理解——能够通过审查代码或阅读映射工具中的条目就搞明白。

- When the database is being viewed as an object store, don’t let the data model and the object model diverge far, regardless of the powers of the mapping tools. Sacrifice some richness of object relationships to keep close to the relational model. Compromise some formal relational standards, such as normalization, if it helps simplify the object mapping.
- Processes outside the object system should not access such an object store. They could violate the invariants enforced by the objects. Also, their access will lock in the data model so that it is hard to change when the objects are refactored.

---

> - 当数据库被视作对象存储时，数据模型与对象模型的差别不应太大（不管映射工具有多么强大的功能）。可以牺牲一些对象关系的丰富性，以保证它与关系模型的紧密关联。如果有助于简化对象映射的话，不妨牺牲某些正式的关系标准（如规范化）。
> - 对象系统外部的过程不应该访问这样的对象存储。它们可能会破坏对象必须满足的固定规则。此外，它们的访问将会锁定数据模型，这样使得在重构对象时很难修改模型。

On the other hand, there are many cases in which the data comes from a legacy or external system that was never intended as a store of objects. In this situation, there are, in reality, two domain models coexisting in the same system. Chapter 14, “Maintaining Model Integrity,” deals with this issue in depth. It may make sense to conform to the model implicit in the other system, or it may be better to make the model completely distinct.

> 另一方面，很多情况下数据是来自遗留系统或外部系统的，而这些系统从来没打算被用作对象的存储。在这种情况下，同一个系统中就会有两个领域模型共存。第 14 章将深入讨论这个问题。或许与另一个系统中隐含的模型保持一致有一定的道理，也可能更好的方法是使这两个模型完全不同。

Another reason for exceptions is performance. Quirky design changes may have to be introduced to solve execution speed problems.

> 允许例外情况的另一个原因是性能。为了解决执行速度的问题，有时可能需要对设计做出一些非常规的修改。

But for the important common case of a relational database acting as the persistent form of an object-oriented domain, simple directness is best. A table row should contain an object, perhaps along with subsidiaries in an AGGREGATE. A foreign key in the table should translate to a reference to another ENTITY object. The necessity of sometimes deviating from this simple directness should not lead to total abandonment of the principle of simple mappings.

> 但大多数情况下关系数据库是面向对象领域中的持久化存储形式，因此简单的对应关系才是最好的。表中的一行应该包含一个对象，也可能还包含 AGGREGATE 中的一些附属项。表中的外键应该转换为对另一个 ENTITY 对象的引用。有时我们不得不违背这种简单的对应关系，但不应该由此就全盘放弃简单映射的原则。

The UBIQUITOUS LANGUAGE can help tie the object and relational components together to a single model. The names and associations of elements in the objects should correspond meticulously to those of the relational tables. Although the power of some mapping tools may make this seem unnecessary, subtle differences in relationships will cause a lot of confusion.

> UBIQUITOUS LANGUAGE 可能有助于将对象和关系组件联系起来，使之成为单一的模型。对象中的元素的名称和关联应该严格地对应于关系表中相应的项。尽管有些功能强大的映射工具使这看上去有些多此一举，但关系中的微小差别可能引发很多混乱。

The tradition of refactoring that has increasingly taken hold in the object world has not really affected relational database design much. What’s more, serious data migration issues discourage frequent change. This may create a drag on the refactoring of the object model, but if the object model and the database model start to diverge, transparency can be lost quickly.

> 对象世界中越来越盛行的重构实际上并没有对关系数据库设计造成多大的影响。此外，一些严重的数据迁移问题也使人们不愿意对数据库进行频繁的修改。这可能会阻碍对象模型的重构，但如果对象模型和数据库模型开始背离，那么很快就会失去透明性。

Finally, there are some reasons to go with a schema that is quite distinct from the object model, even when the database is being created specifically for your system. The database may also be used by other software that will not instantiate objects. The database may require little change, even while the behavior of the objects changes or evolves rapidly. Cutting the two loose from each other is a seductive path. It is often taken unintentionally, when the team fails to keep the database current with the model. If the separation is chosen consciously, it can result in a clean database schema—not an awkward one full of compromises conforming to last year’s object model.

> 最后，有些原因使我们不得不使用与对象模型完全不同的数据库模式，即使数据库是专门为我们的系统创建的。数据库也有可能被其他一些不对对象进行实例化的软件使用。即使当对象的行为快速变化或演变的时候，数据库可能并不需要修改。让模型与数据库之间保持松散的关联是很有吸引力的。但这种结果往往是无意为之，原因是团队没有保持数据库与模型之间的同步。如果有意将两个模型分开，那么它可能会产生更整洁的数据库模式，而不是一个为了与早前的对象模型保持一致而到处都是折中处理的拙劣的数据库模式。
