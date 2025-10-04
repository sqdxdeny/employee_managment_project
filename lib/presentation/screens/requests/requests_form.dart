part of 'requests_screen.dart';

class RequestsForm extends StatelessWidget {
  const RequestsForm({super.key});


  Widget _profileButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person, color: Color(0xFFC0C0C0)),
      onPressed: () {
        context.router.navigate(ProfileRoute());
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF000000),
      title: Text(
        LocaleKeys.requests_screen_title.tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        _profileButton(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<RequestsBloc, RequestsState>(
      buildWhen: (p, c) => p.isLoading != c.isLoading || !listEquals(p.requests, c.requests) || p.sort != c.sort,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final requests = state.requests;

        if (requests.isEmpty) {
          return Center(
            child: Text(
              'There aren\'t any requests yet!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15),
              child: _RequestCard(request: request),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Request request;

  const _RequestCard({required this.request});

  Widget _header(BuildContext context) {
    return Container(
      color: request.type.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              request.id.generate(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Row(
              children: [
                AccountWidget(image: Icon(Icons.account_circle_outlined), name: request.profileId.generate()),
                Expanded(
                  child: Center(
                    child: Text(
                      request.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Text(
      request.description,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: GestureDetector(
        onTap: () {
          /// TODO:
        },
        child: Card(
          color: Colors.black12,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _header(context),
              Flexible(child: _description(context)),
            ],
          ),
        ),
      ),
    );
  }
}
