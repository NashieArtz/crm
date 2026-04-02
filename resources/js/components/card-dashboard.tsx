import {
    Card,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
} from './ui/card';

export function CardDashboard({
    title,
    data,
    description,
}: {
    title: string;
    data: any;
    description: any;
}) {
    return (
        <Card>
            <CardHeader>
                <CardDescription>{title}</CardDescription>
                <CardTitle className="text-5xl font-semibold tabular-nums @[250px]/card:text-3xl">
                    {data}
                </CardTitle>
            </CardHeader>

            <CardFooter className="flex-col items-start gap-2 text-sm">
                <div className="flex gap-2 leading-none font-medium">
                    {description}
                </div>
                <div className="leading-none text-muted-foreground">
                    Ullamcorper in consectetur, gravida molestie, suscipit.
                </div>
            </CardFooter>
        </Card>
    );
}
