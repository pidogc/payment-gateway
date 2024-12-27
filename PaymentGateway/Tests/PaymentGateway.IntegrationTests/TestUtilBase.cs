using Autofac;

namespace PaymentGateway.IntegrationTests;

public class TestUtilBase
{
    private ILifetimeScope _scope;

    protected TestUtilBase(ILifetimeScope scope = null)
    {
        _scope = scope;
    }

    protected void SetupScope(ILifetimeScope scope) => _scope = scope;

    protected void Run<T>(Action<T> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var dependency = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration).Resolve<T>()
            : _scope.BeginLifetimeScope().Resolve<T>();
        action(dependency);
    }

    protected void Run<T, R>(Action<T, R> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<R>();
        action(dependency, dependency2);
    }

    protected void Run<T, R, L>(Action<T, R, L> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<R>();
        var dependency3 = lifetime.Resolve<L>();
        action(dependency, dependency2, dependency3);
    }

    protected async Task Run<T, R, L>(Func<T, R, L, Task> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<R>();
        var dependency3 = lifetime.Resolve<L>();
        await action(dependency, dependency2, dependency3);
    }

    protected async Task Run<T>(Func<T, Task> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var dependency = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration).Resolve<T>()
            : _scope.BeginLifetimeScope().Resolve<T>();
        await action(dependency);
    }

    protected async Task<R> Run<T, R>(Func<T, Task<R>> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var dependency = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration).Resolve<T>()
            : _scope.BeginLifetimeScope().Resolve<T>();
        return await action(dependency);
    }

    protected R Run<T, R>(Func<T, R> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var dependency = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration).Resolve<T>()
            : _scope.BeginLifetimeScope().Resolve<T>();
        return action(dependency);
    }

    protected R Run<T, U, R>(Func<T, U, R> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        return action(dependency, dependency2);
    }

    protected L Run<T, U, R, L>(Func<T, U, R, L> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        return action(dependency, dependency2, dependency3);
    }

    protected Task Run<T, U, R, L, M>(Func<T, U, R, L, M, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5);
    }

    protected Task Run<T, U, R, L>(Func<T, U, R, L, Task> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        return action(dependency, dependency2, dependency3, dependency4);
    }

    protected M Run<T, U, R, L, M>(Func<T, U, R, L, M> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        return action(dependency, dependency2, dependency3, dependency4);
    }

    protected K Run<T, U, R, L, M, K>(Func<T, U, R, L, M, K> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5);
    }

    protected Task Run<T, U>(Func<T, U, Task> action, Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();
        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        return action(dependency, dependency2);
    }

    protected Task Run<T, U, R, L, M, K>(Func<T, U, R, L, M, K, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        var dependency6 = lifetime.Resolve<K>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5, dependency6);
    }

    protected Task Run<T, U, R, L, M, K, O>(Func<T, U, R, L, M, K, O, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        var dependency6 = lifetime.Resolve<K>();
        var dependency7 = lifetime.Resolve<O>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5, dependency6, dependency7);
    }

    protected Task Run<T, U, R, L, M, K, O, P>(Func<T, U, R, L, M, K, O, P, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        var dependency6 = lifetime.Resolve<K>();
        var dependency7 = lifetime.Resolve<O>();
        var dependency8 = lifetime.Resolve<P>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5, dependency6, dependency7,
            dependency8);
    }

    protected Task Run<T, U, R, L, M, K, O, P, Q>(Func<T, U, R, L, M, K, O, P, Q, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        var dependency6 = lifetime.Resolve<K>();
        var dependency7 = lifetime.Resolve<O>();
        var dependency8 = lifetime.Resolve<P>();
        var dependency9 = lifetime.Resolve<Q>();
        return action(dependency, dependency2, dependency3, dependency4, dependency5, dependency6, dependency7,
            dependency8, dependency9);
    }

    protected Task Run<T, U, R, L, M, K, O, P, Q, A, B, C, D, E, F, G>(
        Func<T, U, R, L, M, K, O, P, Q, A, B, C, D, E, F, G, Task> action,
        Action<ContainerBuilder> extraRegistration = null)
    {
        var lifetime = extraRegistration != null
            ? _scope.BeginLifetimeScope(extraRegistration)
            : _scope.BeginLifetimeScope();

        var dependency = lifetime.Resolve<T>();
        var dependency2 = lifetime.Resolve<U>();
        var dependency3 = lifetime.Resolve<R>();
        var dependency4 = lifetime.Resolve<L>();
        var dependency5 = lifetime.Resolve<M>();
        var dependency6 = lifetime.Resolve<K>();
        var dependency7 = lifetime.Resolve<O>();
        var dependency8 = lifetime.Resolve<P>();
        var dependency9 = lifetime.Resolve<Q>();

        var dependency10 = lifetime.Resolve<A>();
        var dependency11 = lifetime.Resolve<B>();
        var dependency12 = lifetime.Resolve<C>();
        var dependency13 = lifetime.Resolve<D>();
        var dependency14 = lifetime.Resolve<E>();
        var dependency15 = lifetime.Resolve<F>();
        var dependency16 = lifetime.Resolve<G>();

        return action(dependency, dependency2, dependency3, dependency4, dependency5, dependency6, dependency7,
            dependency8, dependency9, dependency10, dependency11, dependency12, dependency13, dependency14,
            dependency15,
            dependency16);
    }
}